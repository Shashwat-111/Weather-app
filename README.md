# Weather App Flutter

![Flutter Version](https://img.shields.io/badge/flutter-v3.22.2-blue.svg)
![Dart Version](https://img.shields.io/badge/dart-v3.4.3-blue.svg)

This project is a simple weather app built using Flutter, displaying current weather information for a given city.
The app uses the WeatherAPI.com for weather data and includes an autocomplete feature for city names using Google's Places API

## Screenshots

<p align="center">
  <img src="https://github.com/Shashwat-111/OptionsView/assets/73649098/e0c95b70-975f-4182-8e31-cf65488edec3" alt="QRScannerApp MainPage" width="300" style="margin-right: 20px;"/>
  <img src="https://github.com/Shashwat-111/OptionsView/assets/73649098/624c5a7b-857c-440b-b3f2-879122e8b67a" alt="QRScannerApp DialogBox" width="300" style="margin-left: 20px;"/>
</p>

## Video Demonstration
https://github.com/Shashwat-111/OptionsView/assets/73649098/8f35d730-3714-4934-83eb-be1ed4872180
## Features

- Search bar with autocomplete feature to enter city names.
- Displays city name,current time current temperature (in Celsius), weather condition (e.g., cloudy, sunny, rainy) & Icon representing the weather condition.
- Proper error handling with user-friendly error messages.
- Saves the last searched city

## Installation
1. Clone the repository:
   ```
   git clone https://github.com/Shashwat-111/Weather-app.git
   ```
2. Add API Keys:

    - Go to lib/utils/constants.dart.
    - Add the GooglePlacesAPI key and WeatherAPI key.

4. Install dependencies:
   ```
   flutter pub get
   ```
5. Run the app:
   ```
   flutter run
   ```
