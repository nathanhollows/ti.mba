<?php

namespace App\Freight;

use Phalcon\Mvc\User\Component;

class Freight extends component
{
	public function pbt()
	{
		$config = include __DIR__ . "/../../config/config.php";

		$ftp_server		= $config->pbt->ftpServer;
		$ftp_user_name	= $config->pbt->ftpUserName;
		$ftp_user_pass	= $config->pbt->ftpPassword;

		// set up basic connection
		$conn_id = ftp_connect($ftp_server); 

		// login with username and password
		$login_result = ftp_login($conn_id, $ftp_user_name, $ftp_user_pass); 

		// check connection
		if ((!$conn_id) || (!$login_result)) {
			$this->flash->error("FTP connection has failed !");
		}

		// try to change the directory to somedir
		if (!ftp_chdir($conn_id, "ats")) {
			$this->flash->error("Couldn't change directory");
		}

		// get contents of the current directory
		$contents = ftp_nlist($conn_id, "");

		// output $contents
		//var_dump($contents);
		if (empty($contents)) {
			$this->flash->notice("No files to download!");
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
}