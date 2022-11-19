<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "fuelit";
$table = "registration"; 
$conn = mysqli_connect($servername, $username, $password, $dbname);
$json["data"] = array();
$json["error"] = false;
$json["errmsg"] = "";

 // Check Connection
//if($conn->connect_error){
//die("Connection Failed: " . $conn->connect_error);
//return;
//}

// Get all records from the database

$sql = "SELECT * from $table ORDER BY user_id ";

$result = mysqli_query($conn, $sql);
$num_rows = mysqli_num_rows($result);

if($num_rows > 0){

$namelist = array();

while($array = mysqli_fetch_assoc($result)){
         array_push($json["data"], $array);
}
// Send back the complete records as a json
}else{
      $json["error"] = true;
      $json["errmsg"] = "No any data to show.";
  }

mysqli_close($conn);

echo json_encode($json);

return;
?>