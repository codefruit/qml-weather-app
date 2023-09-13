#pragma once

#include <QObject>
#include <QMutex>
#include <QMap>

#if defined(META)
#undef META
#endif
#define META (static_cast<Meta *>(Meta::instance()))

class Meta : public QObject
{
	Q_OBJECT
	Q_DISABLE_COPY(Meta)

public:
	explicit Meta(QObject *parent = nullptr);
	virtual ~Meta();

	static Meta *instance();
	static void cleanupInstance();
	static bool instantiated() { return Q_NULLPTR != _self; }

	QStringList registeredInstances() const;
	void registerInstance(const QString& inst, QObject* obj);
	QObject *deregisterInstance(const QString& inst);
	void deregisterInstance(QObject* obj);
	Q_INVOKABLE bool hasInstance(const QString& inst) const;
	Q_INVOKABLE bool hasInstance(QObject* obj) const;

	void dump();

signals:
	void registeredInstancesChanged();

public slots:
	QObject* getInstance(const QString& inst) const;

private:
	static Meta *_self;
	static QMutex _mutex;
	QMap<QString, QObject*> _instances;
};
