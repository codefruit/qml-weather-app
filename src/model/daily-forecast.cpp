#include "daily-forecast.h"

DailyForecast::DailyForecast(QObject *parent) : Forecast(parent)
{

}

int DailyForecast::tempMax() const
{
	return m_tempMax;
}

int DailyForecast::tempMin() const
{
	return m_tempMin;
}

int DailyForecast::tempMorning() const
{
	return m_tempMorning;
}

int DailyForecast::tempEve() const
{
	return m_tempEve;
}

int DailyForecast::tempNight() const
{
	return m_tempNight;
}

void DailyForecast::setTempMax(int tempMax)
{
	if (m_tempMax == tempMax)
		return;

	m_tempMax = tempMax;
	emit tempMaxChanged(m_tempMax);
}

void DailyForecast::setTempMin(int tempMin)
{
	if (m_tempMin == tempMin)
		return;

	m_tempMin = tempMin;
	emit tempMinChanged(m_tempMin);
}

void DailyForecast::setTempMorning(int tempMorning)
{
	if (m_tempMorning == tempMorning)
		return;

	m_tempMorning = tempMorning;
	emit tempMorningChanged(m_tempMorning);
}

void DailyForecast::setTempEve(int tempEve)
{
	if (m_tempEve == tempEve)
		return;

	m_tempEve = tempEve;
	emit tempEveChanged(m_tempEve);
}

void DailyForecast::setTempNight(int tempNight)
{
	if (m_tempNight == tempNight)
		return;

	m_tempNight = tempNight;
	emit tempNightChanged(m_tempNight);
}
