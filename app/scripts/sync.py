###
### Don't use this script, it's not finished and it's not being used.
###

import mysql.connector
import win32com.client

MDB_PATH = ''
MYSQL_HOST = ''
MYSQL_USER = ''
MYSQL_PASS = ''
MYSQL_DB = ''
BATCH_SIZE = 100

def open_access_db(db_path):
    conn = win32com.client.Dispatch(r'ADODB.Connection')
    DSN = f'PROVIDER = Microsoft.Jet.OLEDB.4.0;DATA SOURCE = {db_path};'
    conn.Open(DSN)
    return conn

def get_data(conn, query):
    rs = win32com.client.Dispatch(r'ADODB.Recordset')
    rs.Open(query, conn, 1, 3)
    data = rs.GetRows()
    rs.Close()
    return data

def get_freight(conn):
    query = """
    SELECT 
    ttsDespatch.DespatchID, 
      ttsDespatch.OrderNo, 
      FORMAT(ttsDespatch.Date, "yyyy/mm/dd") AS [Time], 
      ttsDespatch.Skid, 
      Carrier.tscaID
    FROM 
      ttsDespatch 
    INNER JOIN 
      Carrier 
    ON 
      ttsDespatch.CarrierID = Carrier.tscaID
    WHERE 
      (ttsDespatch.Skid IS NOT NULL) 
      AND 
      (ttsDespatch.Date BETWEEN (Date() - 5) AND Date());
    """
    return get_data(conn, query)

def get_orders(conn):
    query = """
    SELECT 
      O.OrderNo, 
      O.Customer, 
      Format(O.Date, 'yyyy-mm-dd') AS FormattedDate, 
      O.CustomerRef, 
      O.Description, 
      MAX(ABS(OM.OKToSend)) AS scheduled, 
      E.Name,
      O.Complete
    FROM 
      ([Order] AS O
      LEFT JOIN Employee AS E ON O.AgentID = E.ID)
      LEFT JOIN ttsOrderManagement AS OM ON O.OrderNo = OM.OrderNo
    WHERE 
      O.Type = "CS" AND
      (O.Complete = FALSE 
      OR O.Date >= DateAdd('d', -5, Date()))
    GROUP BY 
      O.OrderNo, 
      O.Customer, 
      Format(O.Date, 'yyyy-mm-dd'),
      O.CustomerRef, 
      O.Description, 
      E.Name,
      O.Complete
    ORDER BY 
      O.OrderNo DESC;
    """
    return get_data(conn, query)

def get_items(conn):
    query = """
    SELECT 
      OI.OrderNo, 
      OI.OrderItem, 
      OI.Grade, 
      OI.Treatment, 
      OI.Dryness, 
      OI.Finish, 
      OI.FinishWidth, 
      OI.FinishThickness, 
      OI.Notes, 
      OI.QuantityOrdered, 
      OI.OrderUnitOfMeasure, 
      OI.QuantityDespatched, 
      OO.Price 
    FROM 
      (([Order] AS O 
      INNER JOIN OrderItem AS OI ON O.OrderNo = OI.OrderNo) 
      INNER JOIN OrderOperations AS OO ON (OI.OrderItem = OO.OrderItem AND OI.OrderNo = OO.OrderNo))
    WHERE 
      (O.Complete = FALSE 
      OR O.Date >= DateAdd('d', -5, Date()))
      AND O.Type = "CS";
    """
    return get_data(conn, query)

def get_scheduled(conn):
    query = """
    SELECT
      ttsOrderManagement.OrderNo,
      ttsOrderManagement.OrderItem
    FROM
      ttsOrderManagement
    WHERE
      (ttsOrderManagement.OKToSend = True);
    """
    return get_data(conn, query)
   
def get_tallies(conn):
    query = """
    SELECT 
      ttsOrderItemTally.OrderNo, 
      ttsOrderItemTally.OrderItem, 
      ttsOrderItemTally.Pieces, 
      ttsOrderItemTally.Length 
    FROM 
      (
        (
          OrderItem 
          INNER JOIN ttsOrderItemTally 
          ON OrderItem.OrderItem = ttsOrderItemTally.OrderItem 
          AND OrderItem.OrderNo = ttsOrderItemTally.OrderNo
        ) 
        INNER JOIN OrderOperations 
        ON OrderItem.OrderItem = OrderOperations.OrderItem 
        AND OrderItem.OrderNo = OrderOperations.OrderNo
      ) 
    WHERE 
      OrderOperations.Status = 'C' 
      AND OrderOperations.Process = 'DSP';
    """
    return get_data(conn, query)

def insert_data_batched(cursor, base_query, data, update_clause=None):
    # Transpose the data from rows to columns
    data = list(map(list, zip(*data)))
    # Function to insert data in batches
    values_str = "(" + ",".join(["%s"] * len(data[0])) + ")"  # Creates a string of '%s' placeholders enclosed in parentheses
    batch_query = base_query.format(values_str)  # Inserts the placeholders into the base query
    
    if update_clause:  # If an update clause was provided, append it to the query
        batch_query += " ON DUPLICATE KEY UPDATE " + update_clause
    
    batch = []  # To hold a batch of rows
    for row in data:
        batch.append(row)
        if len(batch) >= BATCH_SIZE:
            # Execute the batch insert query
            cursor.executemany(batch_query, batch)
            batch.clear()  # Clear the batch

    if batch:  # Insert any remaining rows
        cursor.executemany(batch_query, batch)



def main():
    access_conn = open_access_db(MDB_PATH)
    try:
        mysql_db = mysql.connector.connect(host=MYSQL_HOST, user=MYSQL_USER, password=MYSQL_PASS, database=MYSQL_DB)
        mysql_db.set_charset_collation('utf8', 'utf8_unicode_ci')
        cursor = mysql_db.cursor()

        orders = get_orders(access_conn)
        update_clause = "`description` = VALUES(`description`), `rep` = VALUES(`rep`), `scheduled` = VALUES(`scheduled`), `complete` = VALUES(`complete`)"
        insert_data_batched(cursor, "INSERT INTO `orders`(orderNumber, customerCode, date, customerRef, description, scheduled, rep, complete) VALUES {}", orders, update_clause)
        
        items = get_items(access_conn)
        update_clause = """
        `grade` = VALUES(`grade`), `treatment` = VALUES(`treatment`), `dryness` = VALUES(`dryness`), 
        `finish` = VALUES(`finish`), `width` = VALUES(`width`), `thickness` = VALUES(`thickness`), 
        `notes` = VALUES(`notes`), `ordered` = VALUES(`ordered`), `unit` = VALUES(`unit`), 
        `sent` = VALUES(`sent`), `price` = VALUES(`price`)
        """
        insert_data_batched(cursor, "INSERT INTO `order_items`(orderNo, itemNo, grade, treatment, dryness, finish, width, thickness, notes, ordered, unit, sent, price) VALUES {}", items, update_clause)

        cursor.execute("delete from order_items_scheduled;")
        schedule = get_scheduled(access_conn)
        insert_data_batched(cursor, "INSERT IGNORE INTO `order_items_scheduled`(`orderNumber`, `itemNumber`) VALUES {}", schedule)

        tallies = get_tallies(access_conn)
        update_clause = "`pieces` = VALUES(`pieces`), `length` = VALUES(`length`)"
        insert_data_batched(cursor, "INSERT INTO `order_tallies`(`orderNumber`, `itemNumber`, `pieces`, `length`) VALUES {}", tallies, update_clause)

        freight = get_freight(access_conn)
        update_clause = "`conNote` = VALUES(`conNote`), `carrierID` = VALUES(`carrierID`)"
        insert_data_batched(cursor, "INSERT INTO `dockets`(docketNo, orderno, date, conNote, carrierID) VALUES {}", freight, update_clause)

        mysql_db.commit()
    finally:
        cursor.close()
        mysql_db.close()
        access_conn.Close()

if __name__ == '__main__':
    main()