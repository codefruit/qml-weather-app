#ifndef FORECAST_H
#define FORECAST_H

#include <QObject>
#include <QDate>
#include <QVariant>

#include <QtQml/qqml.h>

class Forecast : public QObject
{
	Q_OBJECT

	Q_PROPERTY(QDateTime timestamp READ timestamp WRITE setTimestamp NOTIFY timestampChanged)
	Q_PROPERTY(QString weather READ weather WRITE setWeather NOTIFY weatherChanged)
	Q_PROPERTY(int weatherCode READ weatherCode WRITE setWeatherCode NOTIFY weatherCodeChanged)
	Q_PROPERTY(QString weatherIcon READ weatherIcon WRITE setWeatherIcon NOTIFY weatherIconChanged)
	Q_PROPERTY(QString weatherDescription READ weatherDescription WRITE setWeatherDescription NOTIFY weatherDescriptionChanged)
	Q_PROPERTY(int temperature READ temperature WRITE setTemperature NOTIFY temperatureChanged)
	Q_PROPERTY(int tempFeel READ tempFeel WRITE setTempFeel NOTIFY tempFeelChanged)	
	Q_PROPERTY(int precipitation READ precipitation WRITE setPrecipitation NOTIFY precipitationChanged)
	Q_PROPERTY(float uvIndex READ uvIndex WRITE setUvIndex NOTIFY uvIndexChanged)

	QML_ELEMENT

public:
	explicit Forecast(QObject *parent = 0);

	QDateTime timestamp() const;
	QString weather() const;
	int weatherCode() const;
	QString weatherIcon() const;
	QString weatherDescription() const;
	int temperature() const;
	int tempFeel() const;	
	int precipitation() const;
	float uvIndex() const;

public slots:
	void setTimestamp(QDateTime timestamp);
	void setWeather(QString weather);
	void setWeatherCode(int weatherCode);
	void setWeatherIcon(QString weatherIcon);
	void setWeatherDescription(QString weatherDescription);
	void setTemperature(int temperature);
	void setTempFeel(int tempFeel);	
	void setPrecipitation(int precipitation);
	void setUvIndex(float newUvIndex);

signals:
	void timestampChanged(QDateTime timestamp);
	void weatherChanged(QString weather);
	void weatherCodeChanged(int weatherCode);
	void weatherIconChanged(QString weatherIcon);
	void weatherDescriptionChanged(QString weatherDescription);
	void temperatureChanged(int temperature);
	void tempFeelChanged(int tempFeel);
	void precipitationChanged(int precipitation);
	void uvIndexChanged(float uvIndex);

private:
	QDateTime m_timestamp;
	QString m_weather;
	int m_weatherCode = -1;
	QString m_weatherIcon;
	QString m_weatherDescription;
	int m_temperature = -1;
	int m_tempFeel = -1;
	int m_precipitation = -1;
	float m_uvIndex = -1.0;
};

#endif // FORECAST_H
