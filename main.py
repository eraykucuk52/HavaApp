# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path
import requests

from PySide6.QtCore import QObject, Signal, Slot
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine




class WeatherApp(QObject):
    def __init__(self):
        QObject.__init__(self)


    temperature = Signal(int, arguments=["number"])
    location = Signal(str, arguments=["value"])
    description = Signal(str, arguments=["valuse_2"])
    iconCode = Signal(str, arguments=["icon"])
    windSpeed = Signal(float, arguments=["windSpeed"])
    sunrise = Signal(str, arguments=["sunriseTime"])
    sunset = Signal(str, arguments=["sunsetTime"])
    apparentTemperature = Signal(float, arguments=["appTemp"])
    windDirection = Signal(str, arguments=["windDir"])
    humidity = Signal(float, arguments=["humidityVal"])





    @Slot(str)
    def updateData(self,city_name):
        print("burasi calisiyo")

        API_KEY = "da544f0632cc4c409b440219371135d3"
        BASE_URL = "https://api.weatherbit.io/v2.0/current"
        params = {"city": city_name, "key": API_KEY,"lang" :"tr" }
        response = requests.get(BASE_URL, params=params)

        if response.status_code == 200:
            data = response.json()["data"][0]
            self.temperature.emit(data["temp"])
            self.location.emit(data["city_name"])
            self.description.emit(data["weather"]["description"])
            self.iconCode.emit(data["weather"]["icon"])
            self.windSpeed.emit(data["wind_spd"])
            self.sunrise.emit(data["sunrise"])
            self.sunset.emit(data["sunset"])
            self.apparentTemperature.emit(data["app_temp"])
            self.windDirection.emit(data["wind_cdir_full"])
            self.humidity.emit(data["rh"])


        else:
            print(f"Error {response.status_code}: Unable to fetch data.")
            return None




if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    weather_app = WeatherApp()
    engine.rootContext().setContextProperty("WeatherApp",weather_app)



    qml_file = Path(__file__).resolve().parent / "main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
