<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "fuelit";
$conn = new mysqli($servername, $username, $password, $dbname);
 // Check Connection
if($conn->connect_error){
die("Connection Failed: " . $conn->connect_error);
return;
}

$dbfuelconsumption=$_POST['dbfuelconsumption'];
$dbamount=$_POST['dbamount'];
$uid=$_POST['dbuid'];
$date=$_POST['dbdate'];
$sql = "INSERT INTO `bill_information`(`fuel_consumption`, `amount`, `user_id`, `date`) VALUES ('$dbfuelconsumption','$dbamount','$uid','$date') ";

if ($conn->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}
$conn->close();
?>