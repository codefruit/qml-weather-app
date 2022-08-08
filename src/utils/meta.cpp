#include "meta.h"

#include <QMutexLocker>
#include <QQmlEngine>

Meta* Meta::_self = Q_NULLPTR;
QMutex Meta::_mutex;

Meta::Meta(QObject *parent) : QObject(parent)
{
	qDebug("Creating Instance Meta...");
	qmlRegisterUncreatableType<Meta>("de.codefruit.utils.cpp", 1, 0, "Meta", "Created in C++ Context");
}

Meta::~Meta()
{
	qDebug("Killing Meta...");
	if (!_instances.isEmpty()) {
		qDebug("Still registered instances: '%s'", qPrintable(_instances.keys().join(",")));
	}
}

Meta *Meta::instance()
{
	QMutexLocker locker(&_mutex);
	if(!_self) {
		_self = new Meta();
	}
	return _self;
}

void Meta::cleanupInstance()
{
	qDebug("Removing Instance Meta...");
	QMutexLocker locker(&_mutex);
	delete _self;
	_self = Q_NULLPTR;
}

QStringList Meta::registeredInstances() const
{
	QMutexLocker locker(&_mutex);
	return _instances.keys();
}

QObject *Meta::getInstance(const QString &inst) const
{
	QMutexLocker locker(&_mutex);
	if(!_instances.contains(inst)) {
		qWarning("instance ('%s') is missing!", qPrintable(inst));
		return Q_NULLPTR;
	} else {
		return _instances.value(inst);
	}
}

void Meta::registerInstance(const QString &inst, QObject *obj)
{
	QMutexLocker locker(&_mutex);
	if(_instances.contains(inst)) {
		qFatal("registerInstance double instance? Or just not deregistered ('%s')", qPrintable(inst));
	}
	QQmlEngine::setObjectOwnership(obj, QQmlEngine::CppOwnership);
	_instances.insert(inst, obj);
	emit registeredInstancesChanged();
}

QObject *Meta::deregisterInstance(const QString &inst)
{
	QObject* obj = nullptr;
	QMutexLocker locker(&_mutex);
	if(!_instances.contains(inst)) {
		qWarning("deregisterInstance ('%s') is missing!", qPrintable(inst));
	} else {
		obj = _instances.take(inst);
		emit registeredInstancesChanged();
	}
	return obj;
}

void Meta::deregisterInstance(QObject *obj)
{
	QMutexLocker locker(&_mutex);
	for(const QString& key : _instances.keys()) {
		if (obj == _instances.value(key)) {
			_instances.remove(key);
			return;
		}
	}

	qWarning("deregisterInstance ('%s') is missing!", qPrintable(obj->metaObject()->className()));
	return;
}

bool Meta::hasInstance(const QString &inst) const
{
	QMutexLocker locker(&_mutex);
	return _instances.contains(inst);
}

bool Meta::hasInstance(QObject *obj) const
{
	QMutexLocker locker(&_mutex);
	for(const QString& key : _instances.keys()) {
		if (obj == _instances.value(key)) {
			return true;
		}
	}
	return false;
}

void Meta::dump()
{
	QString msg;
	int i = 0;
	QMutexLocker locker(&_mutex);

	for(const QString& key : _instances.keys()) {
		const QObject* obj = _instances.value(key);
		msg += QString("%1: %2 - %3 (%4)\n\t")
				.arg(++i)
				.arg(key)
				.arg(obj->objectName())
				.arg(obj->metaObject()->className());
	}

	msg.chop(2);
	qDebug("Meta::dump()\n\t%s", qPrintable(msg));
}
