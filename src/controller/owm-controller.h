#ifndef OWMCONTROLLER_H
#define OWMCONTROLLER_H

#include <QObject>
#include <QQmlListProperty>

#include "model/location.h"
#include "model/weather.h"
#include "model/forecast.h"
#include "model/daily-forecast.h"
#include "utils/owm-icons.h"

class NetworkDataController;
class QSettings;
class OwmController : public QObject
{
	Q_OBJECT

	Q_PROPERTY(Location* location READ location NOTIFY locationChanged)
	Q_PROPERTY(Weather* weather READ weather NOTIFY weatherChanged)
	Q_PROPERTY(QQmlListProperty<Forecast> forecast READ forecast NOTIFY forecastChanged)
	Q_PROPERTY(QQmlListProperty<DailyForecast> dailyForecast READ dailyForecast NOTIFY dailyForecastChanged)

public:
	explicit OwmController(NetworkDataController* ndc, QSettings* settings, QObject *parent = nullptr);

	Location* location() const;
	Weather* weather() const;
	QList<Forecast*> getForecast() const;
	QQmlListProperty<Forecast> forecast();
	QList<DailyForecast*> getDailyForecast() const;
	QQmlListProperty<DailyForecast> dailyForecast();

private:
	QString buildRequstUrl(const QString& base);
	void handleWeatherResponse(const QJsonObject& obj);
	void handleForecastResponse(const QJsonObject& obj);
	Forecast* handleHourlyForecast(const QJsonObject& obj);
	DailyForecast *handleDailyForecast(const QJsonObject& obj);
	void handleGenericForecast(Forecast* forecast, const QJsonObject& obj);


public slots:
	void update(bool force = false);
	void searchByLocation(const QString &location);
	void searchByCode(const QString &code);
	//void dailyForecast(const QString &code); // Replaced by 'oneCallForecast'
	//void hourlyForecast(const QString &code, int count = 48); // Premium API Call...
	void oneCallForecast(float latitude, float longitude);

signals:
	void locationChanged();
	void weatherChanged();
	void forecastChanged();
	void dailyForecastChanged();
	void error(int error, const QString& errorMessage);

private:
	NetworkDataController* _ndc = nullptr;
	QSettings* _settings = nullptr;

	Location* _location;
	Weather* _weather;
	QList<Forecast*> _forecast;
	QList<DailyForecast*> _dailyForecast;
	OwmIcons _icons;
};

#endif // OWMCONTROLLER_H
