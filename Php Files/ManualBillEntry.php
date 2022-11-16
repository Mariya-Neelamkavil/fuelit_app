<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "fuelit";
$table = "bill_information"; // lets create a table named Employees.
$conn = new mysqli($servername, $username, $password, $dbname);
 // Check Connection
if($conn->connect_error){
die("Connection Failed: " . $conn->connect_error);
return;
}

$dbfuelconsumption=$_POST['dbfuelconsumption'];
$dbamount=$_POST['dbamount'];
$sql = "INSERT INTO bill_information (fuel_consumption,amount)
VALUES ('$dbfuelconsumption','$dbamount')";

if ($conn->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}
$conn->close();
?>