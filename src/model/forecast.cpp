#include "forecast.h"

#include <QDebug>

Forecast::Forecast(QObject *parent) : QObject(parent)
{
}

QDateTime Forecast::timestamp() const
{
	return m_timestamp;
}

QString Forecast::weather() const
{
	return m_weather;
}

int Forecast::weatherCode() const
{
	return m_weatherCode;
}

QString Forecast::weatherIcon() const
{
	return m_weatherIcon;
}

QString Forecast::weatherDescription() const
{
	return m_weatherDescription;
}

int Forecast::temperature() const
{
	return m_temperature;
}

int Forecast::tempFeel() const
{
	return m_tempFeel;
}

int Forecast::precipitation() const
{
	return m_precipitation;
}

void Forecast::setTimestamp(QDateTime timestamp)
{
	if (m_timestamp == timestamp)
		return;

	m_timestamp = timestamp;
	emit timestampChanged(m_timestamp);
}

void Forecast::setWeather(QString weather)
{
	if (m_weather == weather)
		return;

	m_weather = weather;
	emit weatherChanged(m_weather);
}

void Forecast::setWeatherCode(int weatherCode)
{
	if (m_weatherCode == weatherCode)
		return;

	m_weatherCode = weatherCode;
	emit weatherCodeChanged(m_weatherCode);
}

void Forecast::setWeatherIcon(QString weatherIcon)
{
	if (m_weatherIcon == weatherIcon)
		return;

	m_weatherIcon = weatherIcon;
	emit weatherIconChanged(m_weatherIcon);
}

void Forecast::setWeatherDescription(QString weatherDescription)
{
	if (m_weatherDescription == weatherDescription)
		return;

	m_weatherDescription = weatherDescription;
	emit weatherDescriptionChanged(m_weatherDescription);
}

void Forecast::setTemperature(int temperature)
{
	if (m_temperature == temperature)
		return;

	m_temperature = temperature;
	emit temperatureChanged(m_temperature);
}

void Forecast::setTempFeel(int tempFeel)
{
	if (m_tempFeel == tempFeel)
		return;

	m_tempFeel = tempFeel;
	emit tempFeelChanged(m_tempFeel);
}

void Forecast::setPrecipitation(int precipitation)
{
	if (m_precipitation == precipitation)
		return;

	m_precipitation = precipitation;
	emit precipitationChanged(m_precipitation);
}

float Forecast::uvIndex() const
{
	return m_uvIndex;
}

void Forecast::setUvIndex(float newUvIndex)
{
	if (qFuzzyCompare(m_uvIndex, newUvIndex))
		return;
	m_uvIndex = newUvIndex;
	emit uvIndexChanged(m_uvIndex);
}
