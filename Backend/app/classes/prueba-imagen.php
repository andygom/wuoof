<?php

/*// Nombre de la imagen
$path = '../img-pets/perrito.jpg';

// Extensión de la imagen
$type = pathinfo($path, PATHINFO_EXTENSION);

// Cargando la imagen
$data = file_get_contents($path);

// Decodificando la imagen en base64
$base64 = 'data:image/' . $type . ';base64,' . base64_encode($data);

// Mostrando la imagen
echo '<img src="'.$base64.'"/>';

echo '<br>';

// Mostrando el código base64
echo $base64;*/

/*$path = 'perrito.jpg';
$type = pathinfo($path, PATHINFO_EXTENSION);
$data = file_get_contents($path);
$base64 = 'data:image/' . $type . ';base64,' . base64_encode($data);
echo $base64;*/



//$rutaImagen = __DIR__ . "/blog.png";
/*$rutaImagen = 'perrito.jpg';
$contenidoBinario = file_get_contents($rutaImagen);
$imagenComoBase64 = base64_encode($contenidoBinario);
echo $imagenComoBase64;*/

/*$cadena = "perrito.jpg";
$codificado = base64_encode($cadena);
echo $codificado;

echo '<br>';
echo '<br>';

//$codificado = "cGFyemlieXRlLm1l";
$decodificado = '../img-pets/'.base64_decode($codificado);
echo $decodificado;

echo '<img src="'.$decodificado.'"/>';*/


//https://www.oscarperez.es/recorrer-un-json-desde-php/
/*$url_gallery = array("cGVycml0by5qcGc", "cGVycml0by5qcGc", "cGVycml0by5qcGc");

$a = array_walk($url_gallery, 'array_decode');

function array_decode(&$item) {
     $item = base64_decode($item);
}

var_dump($a);*/

$url_gallery = array("cGVycml0by5qcGc", "cGVycml0by5qcGc", "cGVycml0by5qcGc");
$nuevo = array();
$array_num = count($url_gallery);
for ($i = 0; $i < $array_num; ++$i){
    $url_gallery[$i] = base64_decode($url_gallery[$i]);
    echo $url_gallery[$i];
    //$url_gallery[$i] = $nuevo;
    //print($nuevo);
    //$url_gallery[$i] = base64_decode($item);
    array_push($nuevo, $url_gallery[$i]);

}
var_dump($nuevo);

echo "<br>";
$codificado = "cGVycml0by5qcGc";
$decodificado = base64_decode($codificado);
echo $decodificado;





?>