QT += quick virtualkeyboard

CONFIG += c++11
CONFIG += qmltypes

QML_IMPORT_MAJOR_VERSION = 1
QML_IMPORT_NAME = de.codefruit.qmlcomponents

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

HEADERS += \
	src/controller/owm-controller.h \
	src/model/daily-forecast.h \
	src/model/forecast.h \
	src/model/location.h \
	src/model/weather.h \
	src/controller/network-data-controller.h \
	src/utils/dumper.h \
	src/utils/meta.h \
	src/utils/owm-icons.h

SOURCES += \
        main.cpp \
	src/controller/owm-controller.cpp \
	src/model/daily-forecast.cpp \
        src/model/forecast.cpp \
	src/model/location.cpp \
        src/model/weather.cpp \
	src/controller/network-data-controller.cpp \
        src/utils/meta.cpp \
        src/utils/owm-icons.cpp

RESOURCES += \
	qml.qrc \
	resource.qrc

TRANSLATIONS += \
	qml-weather-app_de_DE.ts

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

INCLUDEPATH += src/ src/model

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

