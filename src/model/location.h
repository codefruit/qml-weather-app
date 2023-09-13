#ifndef LCATION_H
#define LCATION_H

#include <QObject>

class Location : public QObject
{
	Q_OBJECT

	Q_PROPERTY(QString cityId READ cityId WRITE setCityId NOTIFY cityIdChanged)
	Q_PROPERTY(QString cityName READ cityName WRITE setCityName NOTIFY cityNameChanged)
	Q_PROPERTY(QString countryCode READ countryCode WRITE setCountryCode NOTIFY countryCodeChanged)
	Q_PROPERTY(float latitude READ latitude WRITE setLatitude NOTIFY latitudeChanged)
	Q_PROPERTY(float longitude READ longitude WRITE setLongitude NOTIFY longitudeChanged)

public:
	explicit Location(QObject *parent = nullptr);

	QString cityId() const;
	QString cityName() const;
	QString countryCode() const;
	float latitude() const;
	float longitude() const;

public slots:
	void setCityId(const QString &cityId);
	void setCityName(const QString &cityName);
	void setCountryCode(const QString &countryCode);
	void setLatitude(float latitude);
	void setLongitude(float longitude);

signals:
	void cityIdChanged(QString cityId);
	void cityNameChanged(QString cityName);
	void countryCodeChanged(QString countryCode);
	void latitudeChanged(float latitude);
	void longitudeChanged(float longitude);

private:
	QString _cityId;
	QString _cityName;
	QString _countryCode;
	float _latitude = 0.0;
	float _longitude = 0.0;

};

#endif // LCATION_H
