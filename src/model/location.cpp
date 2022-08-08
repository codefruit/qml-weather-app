#include "location.h"

Location::Location(QObject *parent) : QObject(parent)
{

}

QString Location::cityId() const
{
	return _cityId;
}

QString Location::cityName() const
{
	return _cityName;
}

QString Location::countryCode() const
{
	return _countryCode;
}

float Location::latitude() const
{
	return _latitude;
}

float Location::longitude() const
{
	return _longitude;
}

void Location::setCityId(const QString &cityId)
{
	if (_cityId == cityId)
		return;

	_cityId = cityId;
	emit cityIdChanged(_cityId);
}

void Location::setCityName(const QString &cityName)
{
	if (_cityName == cityName)
		return;

	_cityName = cityName;
	emit cityNameChanged(_cityName);
}

void Location::setCountryCode(const QString &countryCode)
{
	if (_countryCode == countryCode)
		return;

	_countryCode = countryCode;
	emit countryCodeChanged(_countryCode);
}

void Location::setLatitude(float latitude)
{
	if (qFuzzyCompare(_latitude, latitude))
		return;

	_latitude = latitude;
	emit latitudeChanged(_latitude);
}

void Location::setLongitude(float longitude)
{
	if (qFuzzyCompare(_longitude, longitude))
		return;

	_longitude = longitude;
	emit longitudeChanged(_longitude);
}
