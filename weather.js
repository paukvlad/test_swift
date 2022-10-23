const express = require("express")

const app = express()



app.get("/data/2.5/weather", getWeather)



app.listen(3000, function () {
    console.log("Server is running on localhost:3000");
})



function getWeather(req, res) {
    res.json({"coord":{"lon":123.262,"lat":44.5646},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"base":"stations","main":{"temp":290.49,"feels_like":289.48,"temp_min":290.49,"temp_max":290.49,"pressure":1018,"humidity":46,"sea_level":1018,"grnd_level":1001},"visibility":10000,"wind":{"speed":3.16,"deg":81,"gust":3.47},"clouds":{"all":89},"dt":1664606939,"sys":{"country":"CN","sunrise":1664574240,"sunset":1664616565},"timezone":28800,"id":2036338,"name":"Kaitong","cod":200})
}

