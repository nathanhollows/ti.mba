<?php
namespace App\Plugins\Freight;

use Phalcon\Di\Injectable;
use App\Models\Dockets;

class Freight extends Injectable
{
    private function getMainfreightStatus($conNote)
    {
        $ch = curl_init();
        $url = 'https://www.mainfreight.com/track/api/trackings?reference=' . urlencode($conNote);

        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'GET');

        $headers = [];
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

        $result = curl_exec($ch);
        if (curl_errno($ch)) {
            // Handle error
            throw new \Exception('Curl Error: ' . curl_error($ch));
        }

        $status = false;
        if ($result) {
            $data = json_decode($result, true);
            curl_close($ch);
            if (isset($data[0])) {
                return $data[0];
            } else {
                return false;
            }
        }

        curl_close($ch);
    }

    public function trackMainfreight()
    {
        $dockets = Dockets::tracking();
        echo "Tracking " . count($dockets) . " dockets\n";

        foreach ($dockets as $docket) {
            $status = (new self())->getMainfreightStatus($docket->conNote);
            if (!$status) {
                echo "No status for " . $docket->conNote . "\n";
                continue;
            }
            $docket->carrierLabel = str_replace("MSNZS/", "", $status["url"]);
            if ($status["status"] == "Delivered") {
                $docket->delivered = 1;
            } else {
                $docket->delivered = 0;
            }
            $docket->status = $status["status"];
            $docket->update();
            foreach ($docket->getMessages() as $message) {
                echo $message->getMessage() . "\n";
            }
            
        }
    }
}
