#ifndef DAILYFORCEAST_H
#define DAILYFORCEAST_H

#include "forecast.h"
#include <QObject>

class DailyForecast : public Forecast
{
	Q_OBJECT

	Q_PROPERTY(int tempMax READ tempMax WRITE setTempMax NOTIFY tempMaxChanged)
	Q_PROPERTY(int tempMin READ tempMin WRITE setTempMin NOTIFY tempMinChanged)
	Q_PROPERTY(int tempMorning READ tempMorning WRITE setTempMorning NOTIFY tempMorningChanged)
	Q_PROPERTY(int tempEve READ tempEve WRITE setTempEve NOTIFY tempEveChanged)
	Q_PROPERTY(int tempNight READ tempNight WRITE setTempNight NOTIFY tempNightChanged)

	QML_ELEMENT

public:
	explicit DailyForecast(QObject *parent = nullptr);

	int tempMax() const;
	int tempMin() const;
	int tempMorning() const;
	int tempEve() const;
	int tempNight() const;

public slots:
	void setTempMax(int tempMax);
	void setTempMin(int tempMin);
	void setTempMorning(int tempMorning);
	void setTempEve(int tempEve);
	void setTempNight(int tempNight);

signals:
	void tempMaxChanged(int tempMax);
	void tempMinChanged(int tempMin);
	void tempMorningChanged(int tempMorning);
	void tempEveChanged(int tempEve);
	void tempNightChanged(int tempNight);

private:
	int m_tempMax = -1;
	int m_tempMin = -1;
	int m_tempMorning = -1;
	int m_tempEve = -1;
	int m_tempNight = -1;
};

#endif // DAILYFORCEAST_H
