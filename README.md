<!-- ABOUT THE PROJECT -->
## About The Project

[![Product Name Screen Shot][screenshot]](https://example.com)

The "qml-weather-app" is a modern and responsive weather application developed using Qt Quick and leveraging data from the OpenWeatherMap API. The primary goal of this project was to create a modern, responsive user interface using Qt Quick Controls.

### Features
- Current weather display
- Hourly weather forecast
- 7-day weather forecast

### Built With

* [![Qt][qt.io]][qt-url]

<!-- GETTING STARTED -->
## Getting Started

This guide will help you set up a local copy of the project and get it running. Follow these simple steps to get started.

### Prerequisites

Before you begin, ensure you have the necessary tools and libraries installed. For this project, you will need:

- Qt 5 or newer
- A C++ compiler compatible with Qt (e.g., GCC for Linux, MSVC for Windows)
- Qt Creator (optional, but recommended for easier development)

### Building the Project

#### Clone the Project
   - Open a terminal or command prompt.
   - Navigate to the directory where you want to clone the project.
   - Run the following command:
     ```sh
     git clone https://github.com/codefruit/qml-weather-app.git
     ```

#### Using Qt Creator
1. **Open the Project:**
   - Launch Qt Creator.
   - Go to `File > Open File or Project...`.
   - Navigate to the cloned repository and open the `qml-weather-app.pro` project file.

2. **Configure the Project:**
   - Qt Creator will prompt you to configure the project for your development setup.
   - Select the appropriate kit for your platform and compiler.

3. **Build and Run the Application:**
   - Click on the `Build` button in Qt Creator to compile the project.
   - Once the build is successful, click on the `Run` button to start the application.

#### Using the Console (Linux)
1. **Navigate to the Project Directory:**
   - Open a terminal.
   - Navigate to the cloned project directory.

2. **Build the Project:**
   - Run the following commands:
     ```sh
     qmake
     make
     ```

3. **Run the Application:**
   - After a successful build, start the application by running:
     ```sh
     ./qml-weather-app
     ```

<!-- USAGE EXAMPLES -->
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [Using FontAwesome 5 in QML](https://martin.rpdev.net/2018/03/30/using-fontawesome-5-in-qml.html)
* [Font-Awesome](https://github.com/FortAwesome/Font-Awesome)
* [Best-README-Template](https://github.com/othneildrew/Best-README-Template)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[qt.io]: https://img.shields.io/badge/Qt-%23217346.svg?style=for-the-badge&logo=Qt&logoColor=white
[qt-url]: https://www.qt.io/
[screenshot]: resource/images/qml-weather-app.gif