#include "weather.h"
#include "forecast.h"

Weather::Weather(QObject *parent) : QObject(parent)
{

}

void Weather::setWeather(const QString &weather)
{
	if (weather != _weather) {
		_weather = weather;
		emit weatherChanged(_weather);
	}
}
void Weather::setWeatherCode(int weatherCode)
{
	if (weatherCode != _weatherCode) {
		_weatherCode = weatherCode;
		emit weatherCodeChanged(_weatherCode);
	}
}

void Weather::setWeatherIcon(const QString &weatherIcon)
{
	if (weatherIcon != _weatherIcon) {
		_weatherIcon = weatherIcon;
		emit weatherIconChanged(_weatherIcon);
	}
}

QString Weather::weatherIcon() const
{
	return _weatherIcon;
}

void Weather::setWeatherDescription(const QString &weatherDescription)
{
	if (weatherDescription != _weatherDescription) {
		_weatherDescription = weatherDescription;
		emit weatherDescriptionChanged(_weatherDescription);
	}
}

QString Weather::weatherDescription() const
{
	return _weatherDescription;
}

void Weather::setTemperature(int temp)
{
	if (temp != _temperature) {
		_temperature = temp;
		emit temperatureChanged(_temperature);
	}
}

int Weather::temperature() const
{
	return _temperature;
}

void Weather::setPressure(float pressure)
{
	if (!qFuzzyCompare(_pressure,pressure)) {
		_pressure = QString::number(pressure, 'd', 2).toDouble();
		emit pressureChanged(_pressure);
	}
}

float Weather::pressure() const
{
	return _pressure;
}

void Weather::setHumidity(float humidity)
{
	if (!qFuzzyCompare(humidity, _humidity)) {
		_humidity = humidity;
		emit humidityChanged(_humidity);
	}
}

float Weather::humidity() const
{
	return _humidity;
}

void Weather::setWindSpeed(int windSpeed)
{
	if (windSpeed!= _windSpeed) {
		_windSpeed = windSpeed;
		emit windSpeedChanged(_windSpeed);
	}
}

int Weather::windSpeed() const
{
	return _windSpeed;
}

void Weather::setWindDegree(int windDegree)
{
	if (windDegree != _windDegree) {
		_windDegree = windDegree;
		emit windDegreeChanged(_windDegree);
	}
}

int Weather::windDegree() const
{
	return _windDegree;
}

QString Weather::weather() const
{
	return _weather;
}
int Weather::weatherCode() const
{
	return _weatherCode;
}

void Weather::setSunrise(const QString &sunrise)
{
	if (_sunrise != sunrise) {
		_sunrise = sunrise;
		emit sunriseChanged(_sunrise);
	}
}

QString Weather::sunrise() const
{
	return _sunrise;
}

void Weather::setSunset(const QString &sunset)
{
	if (_sunset != sunset) {
		_sunset = sunset;
		emit sunsetChanged(_sunset);
	}
}

QString Weather::sunset() const
{
	return _sunset;
}

void Weather::setTempMax(int tempMax)
{
	if (_tempMax != tempMax) {
		_tempMax = tempMax;
		emit tempMaxChanged(_tempMax);
	}
}

int Weather::tempMax() const
{
	return _tempMax;
}

void Weather::setTempMin(int tempMin)
{
	if (_tempMin != tempMin) {
		_tempMin = tempMin;
		emit tempMinChanged(_tempMin);
	}
}

void Weather::setTempFeel(int tempFeel)
{
	if (_tempFeel == tempFeel)
		return;

	_tempFeel = tempFeel;
	emit tempFeelChanged(_tempFeel);
}

void Weather::setNight(bool night)
{
	if (_night == night)
		return;

	_night = night;
	emit nightChanged(_night);
}

int Weather::tempMin() const
{
	return _tempMin;
}

int Weather::tempFeel() const
{
	return _tempFeel;
}

bool Weather::isNight() const
{
	return _night;
}
