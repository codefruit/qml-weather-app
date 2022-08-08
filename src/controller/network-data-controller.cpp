#include "network-data-controller.h"

NetworkDataController::NetworkDataController(QNetworkAccessManager *nam, QObject *parent) : QObject(parent)
{
	_nam = nam;
}

void NetworkDataController::getDataFromUrl(QString urlString, std::function<void(const QJsonObject&)> callback)
{
	if (urlString.isEmpty()) {
		return;
	}

	QNetworkRequest req;
	req.setUrl(QUrl(urlString));
	req.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");

	QNetworkReply* rply = _nam->get(req);	
	connect(rply, &QNetworkReply::errorOccurred, this, &NetworkDataController::handleNetworkError);

	connect(rply, &QNetworkReply::finished, this, [this, rply, callback](){
		bool okay = false;
		QJsonObject response = readJsonResponse(rply, &okay);
		if (okay) {
			callback(response);
		}		
		rply->deleteLater();
	});

	return;
}

QJsonObject NetworkDataController::readJsonResponse(QNetworkReply *reply, bool *okay)
{
	if (reply->error() != QNetworkReply::NoError) {
		return QJsonObject();
	}

	QString dataRead = reply->readAll();
	QJsonParseError jsonError;
	QJsonDocument jsonResponse = QJsonDocument::fromJson(dataRead.toUtf8(), &jsonError);

	if (jsonError.error != QJsonParseError::NoError) {
		emit networkError(jsonError.error, jsonError.errorString());
		return QJsonObject();
	}

	if (okay != nullptr) {
		*okay = true;
	}

	//qDebug("Response: %s", qPrintable(jsonResponse.toJson(QJsonDocument::Indented)));

	return jsonResponse.object();
}

void NetworkDataController::handleNetworkError(QNetworkReply::NetworkError)
{
	QNetworkReply* rply = qobject_cast<QNetworkReply*>(sender());
	Q_ASSERT(rply);

	//qDebug() << "Network Error: " << rply->errorString();

	emit networkError(rply->error(), rply->errorString());
}
