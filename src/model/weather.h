#ifndef WEATHER_H
#define WEATHER_H

#include <QObject>

class Weather : public QObject {
	Q_OBJECT

	Q_PROPERTY(QString weather READ weather WRITE setWeather NOTIFY weatherChanged)
	Q_PROPERTY(int weatherCode READ weatherCode WRITE setWeatherCode NOTIFY weatherCodeChanged)
	Q_PROPERTY(QString weatherIcon READ weatherIcon WRITE setWeatherIcon NOTIFY weatherIconChanged)
	Q_PROPERTY(QString weatherDescription READ weatherDescription WRITE setWeatherDescription NOTIFY weatherDescriptionChanged)
	Q_PROPERTY(int temperature READ temperature WRITE setTemperature NOTIFY temperatureChanged)
	Q_PROPERTY(float pressure READ pressure WRITE setPressure NOTIFY pressureChanged)
	Q_PROPERTY(int windSpeed READ windSpeed WRITE setWindSpeed NOTIFY windSpeedChanged)
	Q_PROPERTY(int windDegree READ windDegree WRITE setWindDegree NOTIFY windDegreeChanged)
	Q_PROPERTY(int humidity READ humidity WRITE setHumidity NOTIFY humidityChanged)
	Q_PROPERTY(QString sunrise READ sunrise WRITE setSunrise NOTIFY sunriseChanged)
	Q_PROPERTY(QString sunset READ sunset WRITE setSunset NOTIFY sunsetChanged)
	Q_PROPERTY(int tempMax READ tempMax WRITE setTempMax NOTIFY tempMaxChanged)
	Q_PROPERTY(int tempMin READ tempMin WRITE setTempMin NOTIFY tempMinChanged)
	Q_PROPERTY(int tempFeel READ tempFeel WRITE setTempFeel NOTIFY tempFeelChanged)
	Q_PROPERTY(bool night READ isNight WRITE setNight NOTIFY nightChanged)

public:
	explicit Weather(QObject *parent = 0);

	QString weather() const;
	int weatherCode() const;
	QString weatherIcon() const;
	QString weatherDescription() const;
	int temperature() const;
	float pressure() const;
	float humidity() const;
	int windSpeed() const;
	int windDegree() const;
	QString sunrise() const;
	QString sunset() const;
	int tempMax() const;
	int tempMin() const;
	int tempFeel() const;
	bool isNight() const;

public slots:
	void setWeather(const QString &weather);
	void setWeatherCode(int weatherCode);
	void setWeatherIcon(const QString &weatherIcon);
	void setWeatherDescription(const QString &weatherDescription);
	void setTemperature(int temp);
	void setPressure(float pressure);
	void setHumidity(float humidity);
	void setWindSpeed(int windspeed);
	void setWindDegree(int windDegree);	
	void setSunrise(const QString &sunrise);
	void setSunset(const QString &sunset);
	void setTempMax(int tempMax);
	void setTempMin(int tempMin);
	void setTempFeel(int tempFeel);
	void setNight(bool night);

signals:
	void weatherChanged(QString weather);
	void weatherCodeChanged(int weatherCode);
	void weatherIconChanged(QString weatherIcon);
	void weatherDescriptionChanged(QString weatherDescription);
	void temperatureChanged(int temperature);
	void pressureChanged(double pressure);
	void windSpeedChanged(int windSpeed);
	void windDegreeChanged(int windDegree);
	void humidityChanged(int humidity);
	void sunriseChanged(QString sunrise);
	void sunsetChanged(QString sunset);
	void tempMaxChanged(int tempMax);
	void tempMinChanged(int tempMin);	
	void tempFeelChanged(int tempFeel);
	void nightChanged(bool night);

private:
	QString _weather;
	int _weatherCode = -1;
	QString _weatherIcon;
	QString _weatherDescription;
	int _temperature = -1;
	float _pressure = -1.0;
	int _windSpeed = -1;
	int _windDegree = -1;
	float _humidity = -1.0;
	QString _sunrise;
	QString _sunset;
	int _tempMin = -1;
	int _tempMax = -1;
	int _tempFeel = -1;
	bool _night = false;
};

#endif // WEATHER_H
