<?php

namespace App\Plugins\Freight;

use Phalcon\Di\Injectable;
use App\Models\PbtConsignments;

class Freight extends Injectable
{
	public function downloadPBT()
	{
		$config = include __DIR__ . "/../../config/config.php";

        // Check config file before attempting connection
		if ($config->pbt->enable == false) {
			$this->flashSession->error("PBT Connections are disabled. This can be changed in the config file");
			return false;
		}

		if (!empty($config->pbt->ftpServer)) {
			$ftp_server	= $config->pbt->ftpServer;
		} else {
			$this->flashSession->error("The PTB FTP server is not defined in the config. Please check this and try again.");
			return false;
		}

		if (!empty($config->pbt->ftpDirectory)) {
			$ftp_directory	= $config->pbt->ftpDirectory;
		} else {
			$this->flashSession->error("The PTB FTP directory is not defined in the config. Please check this and try again.");
			return false;
		}

		if (!empty($config->pbt->ftpUserName)) {
			$ftp_user_name	= $config->pbt->ftpUserName;
		} else {
			$this->flashSession->error("The PTB FTP username is not defined in the config. Please check this and try again.");
			return false;
		}

		if (!empty($config->pbt->ftpPassword)) {
			$ftp_user_pass	= $config->pbt->ftpPassword;
		} else {
			$this->flashSession->error("The PTB FTP username is not defined in the config. Please check this and try again.");
			return false;
		}

		// set up basic connection
		$conn_id = ftp_connect($ftp_server);
		if (!$conn_id) {
            // Let's try this again. It often fails on the first attempt
            $conn_id = ftp_connect($ftp_server);
    		if (!$conn_id) {
    			$this->flashSession->error("The FTP connection to PBT has failed. Please check the config file and try again.");
    			return false;
    		}
		}

		// login with username and password
		$login_result = ftp_login($conn_id, $ftp_user_name, $ftp_user_pass);

		// check connection
		if ((!$conn_id) || (!$login_result)) {
			$this->flashSession->error("FTP connection has failed !");
			return true;
		}

		ftp_pasv($conn_id, true);

		ftp_chdir($conn_id, $ftp_directory);

		$contents = ftp_nlist($conn_id, "");


		// output $contents
		echo "<pre>";
		echo print_r($contents);
		echo "</pre>";

		if (empty($contents)) {
			$this->flashSession->success("PBT files are up to date");
			return false;
		} else {
			foreach ($contents as $file) {
				$local_file = "ftp/pbt/" . $file;
				$server_file = $file;
				ftp_get($conn_id, $local_file, $server_file, FTP_BINARY);
				$this->flashSession->notice($file . " downloaded.");
				ftp_delete($conn_id, $file);
			}
		}

		// close the connection
		ftp_close($conn_id);

	}

	public function importPBT()
	{

		$dir = getcwd();
		chdir('ftp/pbt/');
		$newDir = getcwd();
		// read input file
		$files = glob('*.txt');
		$filesImported = 0;
		foreach($files as $file) {
			$filesImported ++;
			$fp = fopen($file, "r");


			$row = 1;
			while( ( $data = fgetcsv( $fp, '', "\t" ) ) !== FALSE ) {
				if ($row == 1) {
					$row ++;
				} elseif ($data[4] == 0){
					return true;
				} else {
					$data4 = date_create_from_format('d/m/Y', $data[4]);
					$data5 = date_create_from_format('d/m/Y', $data[5]);

					$import = new PbtConsignments();
					$import->conNote = $data[0];
					$import->pbtConsignmentNote = $data[1];
					$import->numberOfItems = $data[2];
					$import->weight = $data[3];
					$import->pickupDate = date_format($data4, 'Y-m-d');
					$import->podDate = date_format($data5, 'Y-m-d');
					$import->podTime = $data[6];
					$import->deliveryBy = $data[7];
					$import->podSignature = $data[8];
					$import->deliveryCourier = $data[9];
					$import->ticketNo = $data[10];
					$import->cost = $data[11];
					$import->runsheet = $data[12];
					$import->accountNo = $data[13];
					$import->volume = $data[14];
					$success = $import->save();
					if (!$success) {
						foreach ($import->getMessages() as $message) {
							$this->flashSessionSession->error($message->getMessage());
						}

					}
				}

			}

			fclose( $fp );

			rename($file, 'archive/' . $file);

		}

		chdir($dir);
	}
}
