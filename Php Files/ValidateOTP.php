<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "fuelit";
$table = "registration"; // lets create a table named Employees.
$conn = new mysqli($servername, $username, $password, $dbname);
 // Check Connection
if($conn->connect_error){
die("Connection Failed: " . $conn->connect_error);
return;
}

$email_otp=$_POST['email_otp'];
$mobile_otp=$_POST['mobile_otp'];
$sql = "INSERT INTO registration (Name,Mobile_no,Email_ID,User_Name,Password)
VALUES ('$dbfname','$dbmobile','dbemail','dbuname','dbpass')";

if ($conn->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}
$conn->close();
?>