#include "owm-controller.h"

#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QSettings>
#include <QDateTime>

#include "network-data-controller.h"
#include "utils/dumper.h"


static const bool debug_object_dump = false;
void debug_object(QObject* obj) {
	if (debug_object_dump) {
		Dumper::dumpObjectProperties(obj);
		qDebug("**********");
	}
}

OwmController::OwmController(NetworkDataController *ndc, QSettings *settings, QObject *parent) : QObject(parent)
{
	_ndc = ndc;
	_settings = settings;

	_location = new Location(this);
	_weather = new Weather(this);

	connect(_ndc, &NetworkDataController::networkError, this, &OwmController::error);
}

Location *OwmController::location() const
{
	return _location;
}

Weather *OwmController::weather() const
{
	return _weather;
}

QList<Forecast *> OwmController::getForecast() const
{
	return _forecast;
}

QQmlListProperty<Forecast> OwmController::forecast()
{
	return QQmlListProperty<Forecast>(this, &_forecast);
}

QList<DailyForecast *> OwmController::getDailyForecast() const
{
	return _dailyForecast;
}

QQmlListProperty<DailyForecast> OwmController::dailyForecast()
{
	return QQmlListProperty<DailyForecast>(this, &_dailyForecast);
}

void OwmController::update(bool force)
{
	if(_location->cityId().isEmpty() || force) {
		QString cityName = _settings->value("owm/cityName", "").toString();
		QString countryCode = _settings->value("owm/countryCode", "").toString();

		_location->setCityId(""); // Reset CityId to update City data on network response
		_location->setCityName(cityName);
		_location->setCountryCode(countryCode);

		qDebug("[OwmController] Set location: Name: '%s', CountryCode: '%s'",
		       qPrintable(_location->cityName()),
		       qPrintable(_location->countryCode()));

		searchByLocation(cityName + "," + countryCode);
	}
	else {
		searchByCode(_location->cityId());
		oneCallForecast(_location->latitude(), _location->longitude());
	}
}

void OwmController::searchByLocation(const QString &location)
{
	qDebug("[OwmController] Search by location: '%s'", qPrintable(location));
	_ndc->getDataFromUrl(buildRequstUrl("weather?q=" + location), [this](const QJsonObject& response){
		handleWeatherResponse(response);

		oneCallForecast(_location->latitude(), _location->longitude());
	});
}

void OwmController::searchByCode(const QString &code)
{
	qDebug("[OwmController] Search by code: '%s'", qPrintable(code));
	_ndc->getDataFromUrl(buildRequstUrl("weather?id=" + code), [this](const QJsonObject& response){
		handleWeatherResponse(response);
	});
}

/**
 * @brief OwmController::hourlyForecast
 * @param code
 * @param count
 * @warning Premium API Call...
 */
/*
void OwmController::hourlyForecast(const QString &code, int count)
{
	qDebug("[OwmController] Get hourly Forecast: '%s'", qPrintable(code));
	_ndc->getDataFromUrl(buildRequstUrl("forecast/hourly?id=" + code, "&cnt=" + QString::number(count)), [this](const QJsonObject& response){

	});
}
*/

void OwmController::oneCallForecast(float latitude, float longitude)
{
	qDebug("[OwmController] Get 'oneCall' Forecast: lat: '%d', lon: '%d'", latitude, longitude);

	QString base = "onecall?lat=" + QString::number(latitude)
			+ "&lon=" + QString::number(longitude)
			+ "&exclude=current,minutely,alerts" ;

	_ndc->getDataFromUrl(buildRequstUrl(base), [this](const QJsonObject& response){
		handleForecastResponse(response);
	});
}

/**
 * @brief OwmController::dailyForecast
 * @param code
 * @deprecated Replaced by 'oneCallForecast'
 */
/*
void OwmController::dailyForecast(const QString &code)
{
	qDebug("[OwmController] Get daily Forecast: '%s'", qPrintable(code));
	_ndc->getDataFromUrl(buildRequstUrl("forecast/daily?id=" + code), [this](const QJsonObject& response){

	});
}
*/

QString OwmController::buildRequstUrl(const QString &base)
{
	const QString apiKey = _settings->value("owm/apiKey", "").toString();
	const QString systemUnits = _settings->value("general/systemUnits", "metric").toString();
	const QString systemLang = _settings->value("general/systemLang", "de").toString();

	if (apiKey.isEmpty()) {
		emit error(-1, "No Open Weater Map API Key set!");
		return "";
	}

	if (systemUnits.isEmpty()) {
		emit error(-1, "No System Units set!");
		return "";
	}

	if (systemLang.isEmpty()) {
		emit error(-1, "No System Language set!");
		return "";
	}

	static const QString url = "http://api.openweathermap.org/data/2.5/";

	return url + base + "&appid=" + apiKey + "&units=" + systemUnits + "&lang=" + systemLang;
}

void OwmController::handleWeatherResponse(const QJsonObject &obj)
{
	QJsonObject wind = obj["wind"].toObject();
	QJsonObject weather = obj["weather"].toArray().first().toObject();
	QJsonObject sys = obj["sys"].toObject();
	QJsonObject main = obj["main"].toObject();
	QJsonObject coord = obj["coord"].toObject();
	//QJsonObject clouds = obj["clouds"].toObject();

	_weather->setWindDegree(wind["deg"].toInt());
	_weather->setWindSpeed(wind["speed"].toDouble());

	_weather->setWeather(weather["main"].toString());
	_weather->setWeatherDescription(weather["description"].toString());
	_weather->setWeatherCode(weather["id"].toInt());

	_weather->setSunrise(QDateTime::fromTime_t(sys["sunrise"].toInt()).toString(Qt::SystemLocaleShortDate));
	_weather->setSunset(QDateTime::fromTime_t(sys["sunset"].toInt()).toString(Qt::SystemLocaleShortDate));

	_weather->setTemperature(main["temp"].toDouble());
	_weather->setPressure(main["pressure"].toDouble());
	_weather->setHumidity(main["humidity"].toDouble());
	_weather->setTempMax(main["temp_max"].toDouble());
	_weather->setTempMin(main["temp_min"].toDouble());
	_weather->setTempFeel(main["feels_like"].toDouble());

	QTime sunset = QDateTime::fromTime_t(sys["sunset"].toInt()).time();
	QTime current = QTime::currentTime();
	bool night = current > sunset;

	_weather->setNight(night);
	_weather->setWeatherIcon(_icons.icon(_weather->weatherCode(), night));

	if(_location->cityId().isEmpty()) {
		_location->setCityId(QString::number(obj["id"].toInt()));
		_location->setLatitude(coord["lat"].toDouble());
		_location->setLongitude(coord["lon"].toDouble());

		qDebug("[OwmController] Update location: ID: '%s', Longitude: '%f', Latitude: '%f'",
		       qPrintable(_location->cityId()),
		       _location->longitude(),
		       _location->latitude());


		debug_object(_location);
		emit locationChanged();
	}

	debug_object(_weather);
	emit weatherChanged();
}

void OwmController::handleForecastResponse(const QJsonObject &obj)
{
	QJsonArray daily = obj["daily"].toArray();
	QJsonArray hourly = obj["hourly"].toArray();

	QList<DailyForecast*> dfl;
	for (auto d : daily) {
		dfl << handleDailyForecast(d.toObject());
	}

	QDateTime current = QDateTime::currentDateTime();
	QList<Forecast*> fl;
	for (auto h : hourly) {
		Forecast* f = handleHourlyForecast(h.toObject());
		if (current.secsTo(f->timestamp()) <= 43200) {
			fl << f;
		} else {
			f->deleteLater();
		}
	}

	qDebug("[OwmController] Loaded '%d' hourly forecasts", fl.count());
	qDebug("[OwmController] Loaded '%d' daily forecasts", dfl.count());

	QList<DailyForecast*> t_dfl = _dailyForecast;
	_dailyForecast = dfl;
	emit dailyForecastChanged();
	qDeleteAll(t_dfl);

	QList<Forecast*> t_fl = _forecast;
	_forecast = fl;
	emit forecastChanged();
	qDeleteAll(t_fl);

	/*
	Add:
	"timezone": "Europe/Berlin",
	"timezone_offset": 3600
	to -> _location
	*/
}

Forecast* OwmController::handleHourlyForecast(const QJsonObject &obj)
{
	Forecast* f = new Forecast(this);
	handleGenericForecast(f, obj);

	debug_object(f);
	return f;
}

DailyForecast* OwmController::handleDailyForecast(const QJsonObject &obj)
{
	DailyForecast* d = new DailyForecast(this);
	handleGenericForecast(d, obj);

	QJsonObject feels_like = obj["feels_like"].toObject();
	QJsonObject temp = obj["temp"].toObject();

	d->setTemperature(temp["day"].toDouble());
	d->setTempFeel(feels_like["day"].toDouble());
	d->setTempMax(temp["max"].toDouble());
	d->setTempMin(temp["min"].toDouble());
	d->setTempMorning(temp["morn"].toDouble());
	d->setTempEve(temp["eve"].toDouble());
	d->setTempNight(temp["night"].toDouble());

	debug_object(d);
	return d;
}

void OwmController::handleGenericForecast(Forecast *forecast, const QJsonObject &obj)
{
	QJsonObject weather = obj["weather"].toArray().first().toObject();

	forecast->setTimestamp(QDateTime::fromTime_t(obj["dt"].toInt()));
	forecast->setWeather(weather["main"].toString());
	forecast->setWeatherDescription(weather["description"].toString());
	forecast->setWeatherCode(weather["id"].toInt());
	forecast->setWeatherIcon(_icons.icon(forecast->weatherCode(), _weather->isNight()));
	forecast->setTemperature(obj["temp"].toDouble());
	forecast->setTempFeel(obj["feels_like"].toDouble());
	forecast->setPrecipitation(obj["pop"].toDouble() * 100);
}
