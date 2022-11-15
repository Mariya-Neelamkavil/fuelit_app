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

$dbemail=$_POST['dbemail'];
$dbpass=$_POST['dbpass'];
$sql = "INSERT INTO registration (Name,Mobile_no,Email_ID,User_Name,Password)
VALUES ('$dbfname','$dbmobile','$dbemail','$dbuname','$dbpass')";

if ($conn->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}
$conn->close();
?>
////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

<?php 
  $db = "fuelit"; //database name
  $dbuser = "root"; //database username
  $dbpassword = ""; //database password
  $dbhost = "localhost"; //database host

  $return["error"] = false;
  $return["message"] = "";
  $return["success"] = false;

  $link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);

  if(isset($_POST["dbemail"]) && isset($_POST["dbpass"])){
       //checking if there is POST data

       $username = $_POST["dbemail"];
       $password = $_POST["dbpass"];

       $username = mysqli_real_escape_string($link, $username);
       //escape inverted comma query conflict from string

       $sql = "SELECT * FROM registration WHERE username = '$username'";
       //building SQL query
       $res = mysqli_query($link, $sql);
       $numrows = mysqli_num_rows($res);
       //check if there is any row
       if($numrows > 0){
           //is there is any data with that username
           $obj = mysqli_fetch_object($res);
           //get row as object
           if(md5($password) == $obj->password){
               $return["success"] = true;
               $return["uid"] = $obj->user_id;
               $return["fullname"] = $obj->fullname;
               $return["address"] = $obj->address;
           }else{
               $return["error"] = true;
               $return["message"] = "Your Password is Incorrect.";
           }
       }else{
           $return["error"] = true;
           $return["message"] = 'No username found.';
       }
  }else{
      $return["error"] = true;
      $return["message"] = 'Send all parameters.';
  }

  mysqli_close($link);

  header('Content-Type: application/json');
  // tell browser that its a json data
  echo json_encode($return);
  //converting array to JSON string
?>