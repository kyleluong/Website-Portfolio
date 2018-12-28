<?php
	try
{ //Connects to db
$conn = new PDO( "sqlsrv:Server=localhost\SQLEXPRESS01;Database=MMORPG", NULL, NULL);
$conn->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );
}
catch(PDOException $e)
{
die ("Error connecting.");
}

echo "Successfully connected to Kyle's local database!<br>";

$stmt = $conn->prepare("INSERT INTO ACCOUNT
					  (email, phone_number, first_name, last_name,
					   account_name, password_name, birth_date)
					   VALUES (:email, :phone_number, :first_name, :last_name, :account_name, :password_name, :birth_date)");
					   
$stmt->bindParam(':email', $email);					    
$stmt->bindParam(':phone_number', $phone_number);
$stmt->bindParam(':first_name', $first_name);
$stmt->bindParam(':last_name', $last_name);
$stmt->bindParam(':account_name', $account_name);
$stmt->bindParam(':password_name', $password_name);
$stmt->bindParam(':birth_date', $birth_date);


$first_name = $_POST['firstName'];
$last_name = $_POST['lastName'];
$phone_number = $_POST['phoneNumber'];
$birth_date = $_POST['birthDate'];
$email = $_POST['myEmail'];
$account_name = $_POST['userName'];
$password_name = $_POST['password'];

$stmt->execute(); //This only works because I'm using PDO, otherwise a standard sqlsrv_query would use sqlsrv_connect as the alternative option for connection.
		
if ($stmt) {  
    echo "Data successfully inserted";  
	
} else {  
    echo "Data failed to insert	";    
}  

sqlsrv_close ($conn);
 ?>