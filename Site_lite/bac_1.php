<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Interface de Gestion</title>
    <link href="style_bac_1.css" rel="stylesheet" >
    <link rel="stylesheet" href="style_bac_1.css?v=<?php echo filemtime('style_bac_1.css'); ?>">
</head>
<body>

<div class="main-container">

    <header class="top-section">
        <a href="index.php" class="home-link">
            <div class="home-icon">
                <i class="fas fa-home"></i>
            </div>
        </a>
        <div class="alert-banner">
            ALERTE : Pas d'alerte
        </div>
    </header>

    <nav class="action-buttons">
        <button class="btn">Liste des recettes</button>
        <button class="btn">Créer une recette</button>
    </nav>

    <main class="display-area">
    </main>

    <footer class="data-panel">
        <ul>
            <li>Humidité</li>
            <li>Température</li>
            <li>Vent</li>
            <li>Pression</li>
            <li>Ensoleillement</li>
            <li>Taux de croissance : 50%</li>
        </ul>
    </footer>

</div>

</body>
</html>