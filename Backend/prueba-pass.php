<?php

/*$pass = 'ismael';
//echo $pass;
//echo password_hash("rasmuslerdorf", PASSWORD_DEFAULT)."\n";
echo password_hash($pass, PASSWORD_DEFAULT)."\n";*/

$mysqli = new mysqli("localhost", "balaboxd_usrwoof", "thHZJjJYjsEu", "balaboxd_wuoof");
if ($mysqli->connect_errno) {
    echo "Fallo al conectar a MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}
echo $mysqli->host_info . "\n";
//echo "hola";

?>