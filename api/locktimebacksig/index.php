<?php header('Content-Type:application/json; charset=utf-8');
include '../../rngate.php';
include '../apis.php';
$coinnum=explode("_",$_GET["coin_channel"]);
$json='{"data":[{"raw":"","coincli_exe":""}]';
$txid="no";
if(strtoupper($coinnum[0])=="DOGE"){
$rpcs="http://roupay:123@127.0.0.1:22555/";
$burls="https://live.blockcypher.com/doge/tx/";
  include '../../doge'.$coinnum[1].'.php';

$utxo=doCurlPostRequest($rpcs,'{"jsonrpc": "1.0", "id":"curltest", "method": "listunspent", "params": [1,9999999,["'.$getedz.'"],true] }',5);
$n=0;
$outs=explode("txid",$utxo);
$oki="";
for($i=1;$i< count($outs);$i++)
{
	$outids=explode("\"",$outs[$i]);
	$txid=$outids[2];
$n=$outids[5];
$amount=$outids[19];
$n=str_replace(":","",$n);
$n=str_replace(",","",$n);
$amount=str_replace(":","",$amount);
$amount=str_replace(",","",$amount);
$amount=(float)$amount;
if($amount>$roupaybi+$feebi){
  $oki=$oki."|".$i;
  //break;
  }
}
if($oki!=""){
$iii=explode("|",$oki);
$kkk=rand(1, count($iii)-1);
$i=$iii[$kkk];
$outids=explode("\"",$outs[$i]);
	$txid=$outids[2];
$n=$outids[5];
$amount=$outids[19];
$n=str_replace(":","",$n);
$n=str_replace(",","",$n);
$amount=str_replace(":","",$amount);
$amount=str_replace(",","",$amount);
$amount=(float)$amount;
//echo "币UTXO来源： N:".$n."  ".$amount."DOGE<br /><a href='".$burls.$txid."' target=_blank>".$txid."</a>";
 }
}


if(strtoupper($coinnum[0])=="BTC"){
$rpcs="http://roupay:123@127.0.0.1:8333/";
$burls="https://live.blockcypher.com/btc/tx/";
  include '../../btc'.$coinnum[1].'.php';
  
  $iii=explode("|",$ns);
  $mts=explode("|",$amounts);
  $txs=explode("|",$txids);
$kkk=rand(1, count($iii)-1);
$n=$iii[$kkk];
$amount=$mts[$kkk];
$txid=$txs[$kkk];
//echo "币UTXO来源： N:".$n."  ".$amount."BTC<br /><a href='".$burls.$txid."' target=_blank>".$txid."</a>";
}
  

 $dcqm=doCurlPostRequest($rpcs,'{"jsonrpc": "1.0", "id":"curltest", "method": "createmultisig", "params": [2,["'.$_GET["public_key"].'","'.$gatepkey.'"]] }',15);
$madde=json_decode($dcqm, true); 
//var_dump($madde);

if($madde["result"]["address"]!=""&&$txid!="no"&&$amount>=$roupaybi+$feebi){
$zhaoling="";
if($amount>$roupaybi+$feebi)$zhaoling=',"'.$getedz.'":'.($amount-$roupaybi-$feebi);
$dcqm=doCurlPostRequest($rpcs,'{"jsonrpc": "1.0", "id":"curltest", "method": "createrawtransaction", "params": [[{"txid":"'.$txid.'","vout":'.$n.'}],{"'.$madde["result"]["address"].'":'.$roupaybi.$zhaoling.'}] }',15);
$jiayi=explode("\"",$dcqm);
if($jiayi[5]<>"code"){

//echo "<br>构造发通道币交易：<pre style='white-space: pre-wrap;word-break:break-all;'>".$jiayi[3]."</pre>";

$qianming=doCurlPostRequest($rpcs,'{"jsonrpc": "1.0", "id":"curltest", "method": "signrawtransaction", "params": ["'.$jiayi[3].'",[{"txid":"'.$txid.'","vout":'.$n.',"scriptPubKey":"'.$scriptkey.'","redeemScript":""}],["'.$decrypted.'"]] }',15);
$qmtomad=json_decode($qianming, true); 
$raw=$qmtomad["result"]["hex"];
$dzhex=explode("a914",$raw);
for($i=1;$i<count($dzhex);$i++){
  if(substr($dzhex[count($dzhex)-$i],40,2)=="87")
  {$mdzhex=substr($dzhex[count($dzhex)-$i],0,40);
  break;}
}
//echo $mdzhex;
//echo "<br>签名好通道币交易：".$raw[5]."<br>";

//if(!isset($_SESSION['okraw'])){$_SESSION["okraw"]=$raw[5];}//"kjk";
//$_SESSION["okraw"]=$raw[5];
//echo "<br>dd".$_SESSION["okraw"];

$jsonraw=doCurlPostRequest($rpcs,'{"jsonrpc": "1.0", "id":"curltest", "method": "decoderawtransaction", "params": ["'.$raw.'"] }',5);
$tdtxid=explode("\"",$jsonraw);
//echo $jsonraw."<br>签名及解码得交易ID：<br />".$tdtxid[5];

//$sjc=1546272000;//2019-01-01
//if(!empty($_GET["sjcss"])){
//$sjc=$_GET["sjc"];
//}
$sjcjy=doCurlPostRequest($rpcs,'{"jsonrpc": "1.0", "id":"curltest", "method": "createrawtransaction", "params": [[{"txid":"'.$tdtxid[5].'","vout":0}],{"'.$getedz.'":'.$backbi.'},'.$sjc.'] }',15);
$sjcjyhex=explode("\"",$sjcjy);

//echo "<br>加时间戳(<a onclick=\"var newDate = new Date();newDate.setTime(".$sjc." * 1000);alert(newDate.toLocaleString()+'当前时间戳'+Math.round(new Date() / 1000));\">".$sjc."</a>)构造交易";
//<!-- <br>".$sjcjyhex[3]."-->";

$qmsjcjy=doCurlPostRequest($rpcs,'{"jsonrpc": "1.0", "id":"curltest", "method": "signrawtransaction", "params": ["'.$sjcjyhex[3].'",[{"txid":"'.$tdtxid[5].'","vout":0,"scriptPubKey":"a914'.$mdzhex.'87","redeemScript":"'.$madde["result"]["redeemScript"].'"}],["'.$decrypted.'"]] }',15);
$qmraw=explode("\"",$qmsjcjy);

//echo "已经通道对方前面等待您签名的交易：<br><pre style='white-space: pre-wrap;word-break:break-all;'>".$qmraw[5]."</pre>";

$json="dogecoin-cli -datadir=E:\\\\RN signrawtransaction \\\"".$raw."\\\" \\\"[{\\\\\\\"txid\\\\\\\":\\\\\\\"".$tdtxid[5]."\\\\\\\",\\\\\\\"vout\\\\\\\":0,\\\\\\\"scriptPubKey\\\\\\\":\\\\\\\"a914".$mdzhex."87\\\\\\\",\\\\\\\"redeemScript\\\\\\\":\\\\\\\"".$madde["result"]["redeemScript"]."\\\\\\\"}]\\\" \\\"[\\\\\\\"【Private*Key】\\\\\\\"]\\\"";

$json='{"data":[{"raw":"'.$raw.'","txid":"'.$tdtxid[5].'","vout":"0","scriptPubKey":"a914'.$mdzhex.'87","redeemScript":"'.$madde["result"]["redeemScript"].'","coincli_exe":"'.$json.'"}]';
}
else{
$json='{"data":[{"raw":"","coincli_exe":""}]';
}
}
$json=$json.',"context":{"code":200'.$apis.'}}';

if(!empty($_GET["callback"])){
	echo $_GET['callback']."(".$json.")";}
	else{echo $json;}
?>
