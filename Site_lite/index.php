<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <link href="./style.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Optiplant</title>
    <?php 
        $delai = 5; 
        $url = 'index.php';
        header("Refresh: $delai;url=$url");
    ?>
</head>
<body>

<div class="pill-button">OPTIPLANT</div>

<a href="recettes.php" style="text-decoration: none;">
    <button class="pill-button sub-pill">RECETTES</button>
</a>

<div class="dashboard-container">
    <div class="side-column">
        <a href="bac_1.php" class="plant-block" style="text-decoration: none;">
            <div class="alert-bar">ALERTE 1</div>
        </a>
        <a href="bac_1.php" class="plant-block" style="text-decoration: none;">
            <div class="alert-bar">ALERTE 1</div>
        </a>
    </div>

    <div class="data-center">
        <div class="stats-top">
            <?php  
                $bdd=new PDO('mysql:host=localhost;port=3306;dbname=optiplant','root','root');
                $req='SELECT temperature, humidity FROM WEATHER_STATION WHERE id_station = 1;';
                $res=$bdd->query($req);
                $ligne=$res->fetch();
                echo "Température : ".$ligne['temperature']."°C<br>";
                echo "Humidité : ".$ligne['humidity']."%<br>";
            ?>
            <br>
        </div>
        <div class="water-bottom">
            EAU : 60%
        </div>
    </div>

    <div class="side-column">
        <a href="bac_1.php" class="plant-block" style="text-decoration: none;">
            <div class="alert-bar">ALERTE 1</div>
        </a>
        <a href="bac_1.php" class="plant-block" style="text-decoration: none;">
            <div class="alert-bar">ALERTE 1</div>
        </a>
    </div>
</div>

</body>
</html>