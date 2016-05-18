<?php

namespace App\Freight;

use Phalcon\Mvc\User\Component;
use App\Models\PbtConsignments;

class Freight extends component
{
	public function downloadPBT()
	{
		$config = include __DIR__ . "/../../config/config.php";

		if ($config->pbt->enable == false) {
			return false;
		}

		if (!empty($config->pbt->ftpServer)) {
			$ftp_server	= $config->pbt->ftpServer;
		} else {
			$this->flash->error("The PTB FTP server is not defined in the config. Please check this and try again.");
			return true;
		}

		if (!empty($config->pbt->ftpUserName)) {
			$ftp_user_name	= $config->pbt->ftpUserName;
		} else {
			$this->flash->error("The PTB FTP username is not defined in the config. Please check this and try again.");
			return true;
		}

		if (!empty($config->pbt->ftpPassword)) {
			$ftp_user_pass	= $config->pbt->ftpPassword;
		} else {
			$this->flash->error("The PTB FTP username is not defined in the config. Please check this and try again.");
			return true;
		}

		// set up basic connection
		$conn_id = ftp_connect($ftp_server); 
		if (!$conn_id) {
			$this->flash->error("The FTP connection to PBT has failed. Please check the config file and try again.");
		}

		// login with username and password
		$login_result = ftp_login($conn_id, $ftp_user_name, $ftp_user_pass); 

		// check connection
		if ((!$conn_id) || (!$login_result)) {
			$this->flash->error("FTP connection has failed !");
			return true;
		}

		// try to change the directory to somedir
		if (!ftp_chdir($conn_id, "ats")) {
			$this->flash->error("Couldn't change directory");
			return true;
		}

		// get contents of the current directory
		$contents = ftp_nlist($conn_id, "");

		// output $contents
		//var_dump($contents);
		if (empty($contents)) {
			return true;
		} else {
			foreach ($contents as $file) {
				$local_file = 'ftp/pbt/'.$file;
				$server_file = $file;
				$this->flash->notice("File " . $file . " downloaded. </br>");
				ftp_get($conn_id, $local_file, $server_file, FTP_BINARY);
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
		foreach($files as $file) {

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
							$this->flash->error($message->getMessage());
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