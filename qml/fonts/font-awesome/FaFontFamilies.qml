pragma Singleton

import QtQuick 2.12

QtObject {
	id: fonts

	readonly property FontLoader fontAwesomeRegular: FontLoader {
        source: "qrc:/resource/fonts/Font-Awesome-5-Free-Regular-400.otf"
	}
	readonly property FontLoader fontAwesomeSolid: FontLoader {
		source: "qrc:/resource/fonts/Font-Awesome-5-Free-Solid-900.otf"
	}
	readonly property FontLoader fontAwesomeBrands: FontLoader {
		source: "qrc:/resource/fonts/Font-Awesome-5-Brands-Regular-400.otf"
	}

	readonly property string icons: fontAwesomeRegular.name
	readonly property string solidIcons: fontAwesomeSolid.name
	readonly property string brands: fontAwesomeBrands.name
}
