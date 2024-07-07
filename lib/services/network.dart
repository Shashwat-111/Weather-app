import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:weather_app/models/weather_data_model.dart';
import '../utils/constants.dart';
import '../utils/functions.dart';

Future <dynamic> fetchWeatherData ({required String location}) async {
  final Uri uri = Uri.parse("http://api.weatherapi.com/v1/current.json?key=$API_KEY&q=$location");
  try {
    final response = await http.get(uri).timeout(const Duration(seconds: timeoutDuration));
    if (response.statusCode == 200){
      return WeatherData.fromJson(jsonDecode(response.body));
    } else {
      return handleApiError(response);
    }
  }catch (e){
    return "Check Internet Connection";
  }
}

String handleApiError(Response response) {
  switch (response.statusCode) {
    case 401:
      if (response.body.contains('1002')) {
        return 'API key not provided.';
      }
      return 'API key provided is invalid or has exceeded quota.';
    case 400:
      if (response.body.contains('1003')) {
        return 'Invalid Location';
      } else if (response.body.contains('1005')) {
        return 'server currently unreachable';
      } else if (response.body.contains('1006')) {
        return 'No such location available in our database';
      } else if (response.body.contains('9999')) {
        return 'Internal application error.';
      }
      return 'Unknown error occurred';
    case 403:
      if (response.body.contains('2008')) {
        return 'API key has been disabled. Contact developer';
      } else if (response.body.contains('2009')) {
        return 'API key does not have access to the resource.';
      }
      return 'API key has been disabled or does not have access.';
    default:
      return 'Failed to fetch data. Please check your internet connection.';
  }
}

Future <String>? getAutoCompleteData ({required String query}) async {
  try {
    final Uri uri = Uri.parse("https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&types=locality&key=AIzaSyBJafVfNO3KpMhJMVub4YrQR5R5vAiHscg");
    final response = await http.get(uri).timeout(const Duration(seconds: timeoutDuration));
    if (response.statusCode == 200){
      return response.body;
    } else {
      return "Somthing went wrong";
    }
  } catch (e){
    return "No Internet";
  }
}
