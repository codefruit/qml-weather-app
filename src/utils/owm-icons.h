#ifndef OWMICONS_H
#define OWMICONS_H

#include <QObject>
#include <QMap>

class OwmIcons : public QObject
{
	Q_OBJECT
public:
	explicit OwmIcons(QObject *parent = nullptr);

	QString icon(int weatherCode, bool isNight);
	QString icon(int weatherCode);

private:
	QMap<int, QString> _icons;
	QMap<QString, QString> _nightIcons;

};

#endif // OWMICONS_H
