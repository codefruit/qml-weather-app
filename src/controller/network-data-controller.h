#ifndef NETWORKDATACONTROLLER_H
#define NETWORKDATACONTROLLER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QByteArray>
#include <QJsonObject>
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QUrl>

class NetworkDataController : public QObject
{
	Q_OBJECT
public:
	explicit NetworkDataController(QNetworkAccessManager* nam, QObject *parent = nullptr);

	void getDataFromUrl(QString urlString, std::function<void(const QJsonObject&)> callback);

private:
	QJsonObject readJsonResponse(QNetworkReply* reply, bool* okay);

private slots:
	void handleNetworkError(QNetworkReply::NetworkError);

signals:
	void networkError(int error, const QString& errorString);

private:
	QNetworkAccessManager* _nam = nullptr;
};

#endif // NETWORKDATACONTROLLER_H
