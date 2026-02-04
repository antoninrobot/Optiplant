async function getWeather() {
    const apiKey = "cf8b56bcf8ecb228cc4abae0346663be";
    const city = "La Garde";
    const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}&units=metric&lang=fr`;

    try {
        const response = await fetch(url);
        const data = await response.json();
        displayWeather(data);
    } catch (error) {
        console.error("Erreur lors de la récupération des données météo:", error);
    }
}

function displayWeather(data) {

    document.getElementById('meteo-temperature').innerHTML =
        `${data.main.temp} °C`;

    document.getElementById('meteo-feels').innerHTML =
        `${data.main.feels_like} °C`;

    document.getElementById('meteo-humidity').innerHTML =
        `${data.main.humidity} %`;

    document.getElementById('meteo-pressure').innerHTML =
        `${data.main.pressure} hPa`;

    document.getElementById('meteo-wind').innerHTML =
        `${data.wind.speed} m/s`;

    document.getElementById('meteo-clouds').innerHTML =
        `${data.clouds.all} %`;

    document.getElementById('meteo-city').innerHTML =
        `${data.name}, ${data.sys.country}`;

    document.getElementById('meteo-description').innerHTML =
        data.weather[0].description;

    // Lever / coucher du soleil
    const sunrise = new Date(data.sys.sunrise * 1000).toLocaleTimeString('fr-FR');
    const sunset = new Date(data.sys.sunset * 1000).toLocaleTimeString('fr-FR');

    document.getElementById('meteo-sunrise').innerHTML = sunrise;
    document.getElementById('meteo-sunset').innerHTML = sunset;
}

// Appel de la fonction pour récupérer les données
getWeather();