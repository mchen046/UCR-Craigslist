<?php
	$servername = ""; //Enter all credentials
	$serverusername = "";
    $serverpassword = "";
    $databasename = "";
	$conn = mysqli_connect($servername, $serverusername, $serverpassword) or die(mysqli_connect_error());
    mysqli_select_db($conn,$databasename) or die("Cannot connect to database");
?>