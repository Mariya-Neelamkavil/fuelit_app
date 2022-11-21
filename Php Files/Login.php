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

       $sql = "SELECT * FROM registration WHERE username = '$username' and password = '$dbpass'";
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
               $return["name"] = $obj->Name;
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