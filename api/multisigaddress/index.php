<?php header('Content-Type:application/json; charset=utf-8');
function doCurlPostRequest($url,$requestString,$timeout = 5){
 if($url == '' || $requestString == '' || $timeout <=0){
 return false;
 }
 $con = curl_init((string)$url);
 curl_setopt($con, CURLOPT_HEADER, false);
 curl_setopt($con, CURLOPT_POSTFIELDS, $requestString);
 curl_setopt($con, CURLOPT_POST,true);
 curl_setopt($con, CURLOPT_RETURNTRANSFER,true);
 curl_setopt($con, CURLOPT_TIMEOUT,(int)$timeout);
 return curl_exec($con); 
}
  include '../apis.php';
$coinnum=explode("_",$_GET["coin_channel"]);
if(strtoupper($coinnum[0])=="DOGE"){
$rpcs="http://roupay:123@127.0.0.1:22555/";
$burls="https://live.blockcypher.com/doge/address/";
  include '../../doge'.$coinnum[1].'.php';
}
if(strtoupper($coinnum[0])=="BTC"){
$rpcs="http://roupay:123@127.0.0.1:8333/";
$burls="https://live.blockcypher.com/btc/address/";
  include '../../btc'.$coinnum[1].'.php';
}
$dcqm=doCurlPostRequest($rpcs,'{"jsonrpc": "1.0", "id":"curltest", "method": "createmultisig", "params": [2,["'.$_GET["public_key"].'","'.$gatepkey.'"]] }',15);
$madde=json_decode($dcqm, true); 
$json='{"data":[{"maddress":"'.$madde["result"]["address"].'","urls":"'.$burls.$madde["result"]["address"].'"}';

$dcqm=doCurlPostRequest($rpcs,'{"jsonrpc": "1.0", "id":"curltest", "method": "createmultisig", "params": [2,["'.$gatepkey.'","'.$_GET["public_key"].'"]] }',15);
$madde=json_decode($dcqm, true);

$json=$json.',{"maddress":"'.$madde["result"]["address"].'","urls":"'.$burls.$madde["result"]["address"].'"}';
$json=$json.'],"context":{"code":100'.$apis.'}}';

if(!empty($_GET["callback"])){
	echo $_GET['callback']."(".$json.")";}
	else{echo $json;}
?>
