<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Stay Go Turismo</title>
    <link rel="stylesheet" href="../../Web/css/index.css">
    <link rel="stylesheet" href="../../Web/css/Texts.css">
    <link rel="stylesheet" href="../../Web/css/contato.css">
    <?php if($DarkMode ?? false == true): ?>
        <link rel="stylesheet" href="../../Web/css/DarkMode.css">
    <?php else: ?>
        <link rel="stylesheet" href="../../Web/css/LightMode.css">
    <?php endif ?>
</head>
<body>
    <?php 
        include_once(__DIR__ . '../../Components/Menu.php');
        include_once(__DIR__ . '../../Components/Header.php');
        include_once(__DIR__ . '../../Components/Black_BackGround.html');
    ?>
    
    

    <?php
        include_once(__DIR__ . '../../Components/Footer.html');
    ?>

    <script src="../../Web/JavaScript/index.js"></script>
    <script src="../../Web/JavaScript/Global.js"></script>
</body>
</html>