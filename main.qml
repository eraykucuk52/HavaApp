import QtQuick
import QtQuick.Controls

Window {
    width: 675
    height: 475
    title: qsTr("Havanın Nabzı")
    visible: true

    Image {
        source: "background.jpg"
        anchors.fill: parent
        fillMode: Image.Stretch
    }

    Rectangle {
        width: 550
        height: 160
        radius: 60
        color: "white"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 55
        anchors.right: parent.right
        anchors.rightMargin: 62.5
    }
    Item {

        anchors.fill: parent

        TextField {
            id: cityInput
            width: 200
            height: 25
            placeholderText: "Şehir adı girin..."
            anchors.centerIn: parent
            font.pixelSize: 17
        }
        Text {
            text: "havanin_nabzi.py"
            font.pixelSize: 50
            anchors.bottom: cityInput.top
            anchors.bottomMargin: 70
            anchors.right: cityInput.right
            anchors.rightMargin: -100
        }

        Button {
            id: btnId
            width: 60
            height: cityInput.height
            anchors.left: cityInput.right
            anchors.top: cityInput.top
            text: "Ara"
            font.pixelSize: 17
            onClicked: {
                WeatherApp.updateData(cityInput.text)
            }
        }

        Text {
            id: location
            font.pixelSize: 20
            anchors.top: cityInput.bottom
            anchors.topMargin: 30
            anchors.left: cityInput.left
            anchors.leftMargin: -140
        }
        Image {
            id: weatherIcon
            source: "https://www.weatherbit.io/static/img/icons/some_icon.png"
            width: 75
            height: 75
            anchors.top: location.bottom
            anchors.topMargin: -12
            anchors.left: cityInput.left
            anchors.leftMargin: -142

            RotationAnimation on rotation {
                from: 0
                to: 25
                duration: 1000 // 5 saniye sürecek
                loops: Animation.Infinite // Sürekli dönecek
                running: true
            }
        }
        Text {
            id: temperature
            anchors.top: weatherIcon.bottom
            anchors.topMargin: -12
            anchors.left: cityInput.left
            anchors.leftMargin: -140
            font.pixelSize: 17
        }

        Text {
            id: description
            anchors.top: btnId.bottom
            anchors.topMargin: 20

            anchors.left: cityInput.left
            font.pixelSize: 15
        }

        Text {
            id: wind
            anchors.top: description.bottom
            anchors.left: cityInput.left
            font.pixelSize: 15
        }
        Text {
            id: windDirText
            anchors.top: wind.bottom
            anchors.left: wind.left
            font.pixelSize: 15
        }
        Text {
            id: sunriseText
            anchors.top: windDirText.bottom
            anchors.left: windDirText.left
            font.pixelSize: 15
        }

        Text {
            id: sunsetText
            anchors.top: sunriseText.bottom
            anchors.left: sunriseText.left
            font.pixelSize: 15
        }

        Text {
            id: appTempText
            anchors.top: sunsetText.bottom
            anchors.left: sunsetText.left
            font.pixelSize: 15
        }

        Text {
            id: humidityText
            anchors.top: appTempText.bottom
            anchors.left: appTempText.left
            font.pixelSize: 15
        }

        Connections {
            target: WeatherApp
            function onTemperature(number) {
                temperature.text = "Sıcaklık: " + number + "°C"
            }
            function onLocation(value) {
                location.text = value
            }
            function onDescription(value) {
                description.text = "Havanın Nabzı: " + value
            }
            function onIconCode(icon) {
                weatherIcon.source = "https://www.weatherbit.io/static/img/icons/" + icon + ".png"
            }
            function onWindSpeed(speed) {
                wind.text = "Rüzgar Hızı: " + speed + " m/s"
            }
            function onSunrise(sunriseTime) {
                sunriseText.text = "Sunrise: " + sunriseTime
            }

            function onSunset(sunsetTime) {
                sunsetText.text = "Sunset: " + sunsetTime
            }

            function onApparentTemperature(appTemp) {
                appTempText.text = "Hissedilen Sıcaklık: " + appTemp + "°C"
            }

            function onWindDirection(windDir) {
                windDirText.text = "Rüzgar Yönü: " + windDir
            }

            function onHumidity(humidityVal) {
                humidityText.text = "Bağıl Nem: " + humidityVal + "%"
            }
        }
    }
}
