<!-- ABOUT THE PROJECT -->
## qml-weather-app

[![Product Name Screen Shot][screenshot]](https://example.com)

The `qml-weather-app` is a modern and responsive weather application developed using Qt Quick and leveraging data from the OpenWeatherMap API. The primary goal of this project was to create a modern, responsive user interface using Qt Quick Controls.

### Features
- Current weather display
- Hourly weather forecast
- 8-day weather forecast
- Customizable Settings

### Built With

* [![Qt][qt.io]][qt-url]

<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

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

To fully utilize the `qml-weather-app`, you need an API key from OpenWeatherMap. This key allows the app to fetch weather data. Follow these steps to get started:

### Obtaining an OpenWeatherMap API Key

1. **Create an Account:**
   - Visit [OpenWeatherMap](https://openweathermap.org/appid) and sign up for an account if you don't already have one.

2. **Generate an API Key:**
   - Once logged in, navigate to the API keys section and generate a new API key.
   - It may take a few minutes for the API key to become active.

3. **Copy the API Key:**
   - Copy the generated API key for use in the `qml-weather-app`.

### Configuring the App

1. **Start the `qml-weather-app`:**
   - Launch the application on your system.

2. **Access Settings:**
   - Navigate to the Settings tab within the app.

3. **Enter API Key and Location:**
   - Enter the OpenWeatherMap API Key in the designated field.
   - Specify the city and country code for which you want to receive weather data. For example, `Berlin` and `DE` for Berlin, Germany.

4. **Test Settings:**
   - Use the Test button to verify if the settings are correct and the app can retrieve weather data successfully.

Once the API key and location are configured, the app will display weather information based on your settings.

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [Weather Icons](https://github.com/erikflowers/weather-icons)
* [Using FontAwesome 5 in QML](https://martin.rpdev.net/2018/03/30/using-fontawesome-5-in-qml.html)
* [Font-Awesome](https://github.com/FortAwesome/Font-Awesome)
* [Best-README-Template](https://github.com/othneildrew/Best-README-Template)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[qt.io]: https://img.shields.io/badge/Qt-%23217346.svg?style=for-the-badge&logo=Qt&logoColor=white
[qt-url]: https://www.qt.io/
[screenshot]: resource/images/qml-weather-app.gif