#ifndef DUMPER_H
#define DUMPER_H

#include <QDebug>
#include <QMetaProperty>

#include <vector>
#include <utility>
#include <algorithm>

namespace Dumper {
static void dumpObjectProperties(QObject *o)
{
	auto mo = o->metaObject();
	qDebug() << "## Properties of" << o << "##";
	do {
		qDebug() << "### Class" << mo->className() << "###";
		std::vector<std::pair<QString, QVariant> > v;
		v.reserve(mo->propertyCount() - mo->propertyOffset());
		for (int i = mo->propertyOffset(); i < mo->propertyCount();
		     ++i)
			v.emplace_back(mo->property(i).name(),
				       mo->property(i).read(o));
		std::sort(v.begin(), v.end());
		for (auto &i : v)
			qDebug() << i.first << "=>" << i.second;
	} while ((mo = mo->superClass()));
}
}

#endif // DUMPER_H
