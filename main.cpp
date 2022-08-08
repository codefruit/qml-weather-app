#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QNetworkAccessManager>
#include <QSettings>

#include "src/controller/network-data-controller.h"
#include "src/controller/owm-controller.h"

int main(int argc, char *argv[])
{
	qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

	if (qEnvironmentVariableIsEmpty("QTGLESSTREAM_DISPLAY")) {
		qputenv("QT_QPA_EGLFS_PHYSICAL_WIDTH", QByteArray("213"));
		qputenv("QT_QPA_EGLFS_PHYSICAL_HEIGHT", QByteArray("120"));

		QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
	}

	QGuiApplication app(argc, argv);
	app.setOrganizationName("codefruit");
	app.setOrganizationDomain("codefruit.de");
	app.setApplicationName("QML Weather App");

	QSettings* settings = new QSettings();

	/*
	settings->setValue("owm/apiKey", "9fab8697474d6b9aa3cc1c50fd101c4f");
	settings->setValue("owm/cityName", "ganderkesee");
	settings->setValue("owm/countryCode", "de");

	settings->setValue("general/temperatureUnit", "c");
	settings->setValue("general/systemLang", "de");
	settings->setValue("general/systemUnits", "metric");
	*/

	QNetworkAccessManager* nam = new QNetworkAccessManager();
	NetworkDataController* ndc = new NetworkDataController(nam);
	OwmController* wc = new OwmController(ndc, settings);

	QQmlApplicationEngine engine;
	engine.rootContext()->setContextProperty("NetworkDataController", ndc);
	engine.rootContext()->setContextProperty("OwmController", wc);

	const QUrl url(QStringLiteral("qrc:/main.qml"));
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
			 &app, [url](QObject *obj, const QUrl &objUrl) {
		if (!obj && url == objUrl)
			QCoreApplication::exit(-1);
	}, Qt::QueuedConnection);
	engine.load(url);

	int rt = app.exec();

	settings->sync();	
	qDeleteAll(engine.rootObjects());

	delete wc;
	delete ndc;
	delete nam;
	delete settings;

	return rt;
}
