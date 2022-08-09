pragma Singleton

import QtQuick 2.12

QtObject {
	id: fonts

	readonly property FontLoader weatherIconsRegular: FontLoader {
        source: "qrc:/resource/fonts/weathericons-regular-webfont.ttf"
	}

	readonly property string icons: weatherIconsRegular.name
}
