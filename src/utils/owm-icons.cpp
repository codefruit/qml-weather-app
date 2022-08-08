#include "owm-icons.h"

static const QChar DefaultIcon = QChar(0xf07b);

OwmIcons::OwmIcons(QObject *parent) : QObject(parent)
{
	_icons.insert(0,QChar(0xf056)); //tornado
	//Thunderstorms icons
	_icons.insert(200, QChar(0xf00e)); //thunderstorm with light rain
	_icons.insert(201, QChar(0xf00e)); //thunderstorm with rain
	_icons.insert(202, QChar(0xf010)); //thunderstorm with heavy rain
	_icons.insert(210, QChar(0xf00e)); //light thunderstorm
	_icons.insert(211, QChar(0xf010)); //thunderstorm
	_icons.insert(212, QChar(0xf010)); //heavy thunderstorm
	_icons.insert(221, QChar(0xf00e)); //ragged thunderstorm
	_icons.insert(230, QChar(0xf00e)); //thunderstorm with light drizzle
	_icons.insert(231, QChar(0xf00e)); //thunderstorm with drizzle
	_icons.insert(232, QChar(0xf00e)); //thunderstorm with heavy drizzle
	//Drizzle icons
	_icons.insert(300, QChar(0xf00b)); //light intensity drizzle
	_icons.insert(301, QChar(0xf00b)); //drizzle
	_icons.insert(302, QChar(0xf00b)); //heavy intensity drizzle
	_icons.insert(310, QChar(0xf00b)); //light intensity drizzle rain
	_icons.insert(311, QChar(0xf009)); //drizzle rain
	_icons.insert(312, QChar(0xf009)); //heavy intensity drizzle rain
	_icons.insert(313, QChar(0xf009)); //shower rain and drizzle
	_icons.insert(314, QChar(0xf009)); //heavy shower rain and drizzle
	_icons.insert(321, QChar(0xf009)); //shower drizzle
	//Rain
	_icons.insert(500, QChar(0xf009)); //light rain
	_icons.insert(501, QChar(0xf009)); //moderate rain
	_icons.insert(502, QChar(0xf009)); //heavy intensity rain
	_icons.insert(503, QChar(0xf009)); //very heavy rain
	_icons.insert(504, QChar(0xf008)); //extreme rain
	_icons.insert(511, QChar(0xf008)); //freezing rain
	_icons.insert(520, QChar(0xf008)); //light intensity shower rain
	_icons.insert(521, QChar(0xf009)); //shower rain
	_icons.insert(522, QChar(0xf009)); //heavy intensity shower rain
	_icons.insert(531, QChar(0xf009)); //ragged shower rain
	//Snow
	_icons.insert(600, QChar(0xf00a)); //light snow
	_icons.insert(601, QChar(0xf00a)); //snow
	_icons.insert(602, QChar(0xf00a)); //heavy snow
	_icons.insert(611, QChar(0xf0b2)); //sleet
	_icons.insert(612, QChar(0xf0b2)); //shower sleet
	_icons.insert(615, QChar(0xf0b2)); //light rain and snow
	_icons.insert(616, QChar(0xf006)); //rain and snow
	_icons.insert(620, QChar(0xf00a)); //light shower snow
	_icons.insert(621, QChar(0xf065)); //shower snow
	_icons.insert(622, QChar(0xf065)); //heavy shower snow
	//Atmosphere
	_icons.insert(701, QChar(0xf003)); //mist
	_icons.insert(711, QChar(0xf062)); //smoke
	_icons.insert(721, QChar(0xf0b6)); //haze
	_icons.insert(731, QChar(0xf063)); //sand, dust whirls
	_icons.insert(741, QChar(0xf003)); //fog
	_icons.insert(751, QChar(0xf063)); //sand
	_icons.insert(761, QChar(0xf063)); //dust
	_icons.insert(762, QChar(0xf0c8)); //volcanic ash
	_icons.insert(771, QChar(0xf050)); //squalls
	_icons.insert(781, QChar(0xf056)); //tornado
	//Clear
	_icons.insert(800, QChar(0xf00d)); //clear sky
	//Clouds
	_icons.insert(801, QChar(0xf002)); //few clouds
	_icons.insert(802, QChar(0xf002)); //scattered clouds
	_icons.insert(803, QChar(0xf002)); //broken clouds
	_icons.insert(804, QChar(0xf002)); //overcast clouds
	//Extreme
	_icons.insert(900, QChar(0xf056)); //tornado
	_icons.insert(901, QChar(0xf01d)); //tropical storm
	_icons.insert(902, QChar(0xf073)); //hurricane
	_icons.insert(903, QChar(0xf076)); //cold
	_icons.insert(904, QChar(0xf072)); //hot
	_icons.insert(905, QChar(0xf021)); //windy
	_icons.insert(906, QChar(0xf004)); //hail
	//Additional
	_icons.insert(951, QChar(0xf00d)); //calm
	_icons.insert(952, QChar(0xf0c4)); //light breeze
	_icons.insert(953, QChar(0xf0c4)); //gentle breeze
	_icons.insert(954, QChar(0xf0c4)); //moderate breeze
	_icons.insert(955, QChar(0xf0c4)); //fresh breeze
	_icons.insert(956, QChar(0xf021)); //strong breeze
	_icons.insert(957, QChar(0xf021)); //high wind, near gale
	_icons.insert(958, QChar(0xf050)); //gale
	_icons.insert(959, QChar(0xf050)); //severe gale
	_icons.insert(960, QChar(0xf010)); //storm
	_icons.insert(961, QChar(0xf010)); //violent storm
	_icons.insert(962, QChar(0xf073)); //hurricane


	//
	// Lookup Table after Sunset
	_nightIcons.insert(QChar(0xf00d), QChar(0xf02e));
	_nightIcons.insert(QChar(0xf002), QChar(0xf086));
	_nightIcons.insert(QChar(0xf000), QChar(0xf022));
	_nightIcons.insert(QChar(0xf003), QChar(0xf04a));
	_nightIcons.insert(QChar(0xf004), QChar(0xf024));
	_nightIcons.insert(QChar(0xf0b6), QChar(0xf0b6));
	_nightIcons.insert(QChar(0xf005), QChar(0xf033));
	_nightIcons.insert(QChar(0xf008), QChar(0xf036));
	_nightIcons.insert(QChar(0xf006), QChar(0xf026));
	_nightIcons.insert(QChar(0xf007), QChar(0xf027));
	_nightIcons.insert(QChar(0xf009), QChar(0xf029));
	_nightIcons.insert(QChar(0xf0b2), QChar(0xf0b4));
	_nightIcons.insert(QChar(0xf068), QChar(0xf06a));
	_nightIcons.insert(QChar(0xf00a), QChar(0xf02a));
	_nightIcons.insert(QChar(0xf06b), QChar(0xf06d));
	_nightIcons.insert(QChar(0xf065), QChar(0xf067));
	_nightIcons.insert(QChar(0xf00b), QChar(0xf02b));
	_nightIcons.insert(QChar(0xf00e), QChar(0xf02c));
	_nightIcons.insert(QChar(0xf00c), QChar(0xf083));
	_nightIcons.insert(QChar(0xf010), QChar(0xf03b));
	_nightIcons.insert(QChar(0xf085), QChar(0xf021));
	_nightIcons.insert(QChar(0xf06e), QChar(0xf070));
	_nightIcons.insert(QChar(0xf072), QChar(0xf077));
	_nightIcons.insert(QChar(0xf07d), QChar(0xf080));
	_nightIcons.insert(QChar(0xf0c4), QChar(0xf021));
}

QString OwmIcons::icon(int weatherCode, bool isNight)
{
	QString dayIcon = icon(weatherCode);
	if (isNight && _nightIcons.contains(dayIcon)) {
		return _nightIcons.value(dayIcon, DefaultIcon);
	}

	return dayIcon;
}

QString OwmIcons::icon(int weatherCode) {
	if (_icons.contains(weatherCode)) {
		return _icons.value(weatherCode, DefaultIcon);
	}
	else {
		return DefaultIcon;
	}
}
