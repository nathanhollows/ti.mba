function cloneRow() {
  var row = document.getElementById("rowToClone"); // find row to copy
  var table = document.getElementById("items"); // find table to append to
  var clone = row.cloneNode(true); // copy children too
  clone.id = "newID"; // change id or other attributes/contents
  table.appendChild(clone); // add new row to end of table
  $('.selectpicker').selectpicker('refresh');
}
$(document).ready(cloneRow);