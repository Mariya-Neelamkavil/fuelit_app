<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "fuelit";

$conn = mysqli_connect($servername, $username, $password, $dbname);
$json["data"] = array();
$json["error"] = false;
$json["errmsg"] = "";
$end_date = new DateTime(date('Y-m-d'));
$end_date->modify('-1 months');
$date = $end_date->format('Y-m-d');
$uid=$_POST['dbuid'];
      

$sql = "SELECT * FROM `bill_information` WHERE date > '$date' and user_id = '$uid'";

$result = mysqli_query($conn, $sql);
$num_rows = mysqli_num_rows($result);



if($num_rows > 0){

$namelist = array();

while($array = mysqli_fetch_assoc($result)){
	
        $namelist[]=$array;
}
// Send back the complete records as a json
}else{
      $json["error"] = true;
      $json["errmsg"] = "No data to show.";
  }

mysqli_close($conn);
$json["data"]=$namelist;
$obj = json_encode($json);


echo($obj);


return;
?>