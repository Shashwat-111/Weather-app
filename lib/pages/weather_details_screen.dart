import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_data_model.dart';
import '../models/autocomplete_prediction_model.dart';
import '../services/network.dart';
import '../utils/constants.dart';
import '../utils/functions.dart';
import '../utils/icon.dart';
import '../widgets/weather_details_box.dart';

class WeatherDetailScreen extends StatefulWidget {
  final Prediction prediction;
  const WeatherDetailScreen({super.key, required this.prediction});

  @override
  State<WeatherDetailScreen> createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  late Color defaultColor = Colors.black;
  bool isLoading = true;
  late WeatherData weatherData;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  getWeatherData() async {
    var result =
        await fetchWeatherData(location: widget.prediction.description);
    if (result is WeatherData) {
      setState(() {
        weatherData = result;
        isLoading = false;
      });
    } else {
      setState(() {
        errorMessage = result;
        isLoading = false;
      });
      showErrorSnackbar(result);
    }
  }

  void showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent[200],
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (errorMessage != null) {
      //todo make a error page
      return Scaffold(body: Center(child: Text(errorMessage!)));
    } else {
      //setting the icon and text color based on day or night
      weatherData.current.isDay == 1
          ? defaultColor = dayColor
          : defaultColor = nightColor;
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          extendBodyBehindAppBar: true,
          appBar: buildAppBar(context),
          body: Container(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              decoration: BoxDecoration(
                  gradient: getGradient(weatherData.current.isDay)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  buildPlaceAndTimeDetailRow(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: buildTemperatureText(),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: buildWeatherIcon(),
                  ),
                  buildWeatherConditionText(),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WeatherDetailsBox(
                        displayText: "Humidity",
                        sign: "%",
                        value: weatherData.current.humidity,
                        whiteIcon: humidityIconWhite,
                        blackIcon: humidityIconBlack,
                        defaultColor: defaultColor,
                        isDay: weatherData.current.isDay,
                      ),
                      WeatherDetailsBox(
                        displayText: "Windspeed",
                        sign: "km/h",
                        value: weatherData.current.windKph,
                        whiteIcon: windIconWhite,
                        blackIcon: windIconBlack,
                        defaultColor: defaultColor,
                        isDay: weatherData.current.isDay,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WeatherDetailsBox(
                        displayText: "Precipitation",
                        sign: " mm",
                        value: weatherData.current.precipMm,
                        whiteIcon: rainIconWhite,
                        blackIcon: rainIconBlack,
                        defaultColor: defaultColor,
                        isDay: weatherData.current.isDay,
                      ),
                      WeatherDetailsBox(
                        displayText: "Wind Angle",
                        sign: "\u00b0",
                        value: "${weatherData.current.windDir} ${weatherData.current.windDegree}",
                        whiteIcon: windAngleIconWhite,
                        blackIcon: windAngleIconBlack,
                        defaultColor: defaultColor,
                        isDay: weatherData.current.isDay,
                      )
                    ],
                  ),
                  const Spacer()
                ],
              )),
        ),
      );
    }
  }

  Widget buildWeatherConditionText() => Text(
      weatherData.current.condition.text,
      style: TextStyle(
          color: defaultColor, fontSize: 25, fontWeight: FontWeight.w300),
    textAlign: TextAlign.center,
  );

  Widget buildWeatherIcon() => Image.asset(getImage(weatherData!.current.condition.code,
      weatherData!.current.isDay), scale: 0.7);

  Widget buildTemperatureText() {
    return Text(
      "${weatherData.current.tempC.ceil().toString()}\u2103",
      style: TextStyle(
          color: defaultColor, fontSize: 80, fontWeight: FontWeight.w300),
    );
  }

  Widget buildPlaceAndTimeDetailRow() {
    return Row(
      children: [
        Text(weatherData.location.name,
            style: TextStyle(
                color: defaultColor,
                fontSize: 35,
                fontWeight: FontWeight.w300)),
        Icon(
          Icons.location_pin,
          color: defaultColor,
          size: 30,
        ),
        const Spacer(),
        Text(formatDateTime(weatherData.location.localtime),
            style: TextStyle(
                color: defaultColor, fontSize: 20, fontWeight: FontWeight.w300))
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: defaultColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.refresh,
            color: defaultColor,
          ),
          onPressed: () {
            setState(() {
              isLoading = true;
              getWeatherData();
            });
          },
        )
      ],
    );
  }
}
