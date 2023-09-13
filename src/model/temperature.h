#ifndef TEMPERATURE_H
#define TEMPERATURE_H

#include <QObject>

class Temperature : public QObject
{
	Q_OBJECT

	Q_PROPERTY(int temperature READ temperature WRITE setTemperature NOTIFY temperatureChanged)
	Q_PROPERTY(int tempMax READ tempMax WRITE setTempMax NOTIFY tempMaxChanged)
	Q_PROPERTY(int tempMin READ tempMin WRITE setTempMin NOTIFY tempMinChanged)
	Q_PROPERTY(int tempFeel READ tempFeel WRITE setTempFeel NOTIFY tempFeelChanged)
	Q_PROPERTY(bool night READ isNight WRITE setNight NOTIFY nightChanged)
public:
	explicit Temperature(QObject *parent = nullptr);

signals:

};

#endif // TEMPERATURE_H
