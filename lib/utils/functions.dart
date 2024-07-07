import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utils/icon.dart';

LinearGradient getGradient(int isDay) {
  return isDay == 1
      ? const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color.fromRGBO(188, 232, 255, 1), Colors.white])
      : const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.black, Color.fromRGBO(29, 40, 55, 1)]);
}

String formatDateTime(String dateTimeString) {
  DateTime dateTime = DateFormat("yyyy-MM-dd H:mm").parse(dateTimeString);
  String formattedTime = DateFormat.jm().format(dateTime);
  return formattedTime;
}

String getImage(int weatherConditionCode, int isDay) {
  switch (weatherConditionCode) {
    case 1000:
      return isDay == 1 ? sunnyDayIcon : clearNightIcon;
    case 1003:
    case 1006:
    case 1009:
    case 1030:
    case 1135:
    case 1147:
      return partlyCloudyDayIcon;
    case 1063:
    case 1087:
    case 1150:
    case 1153:
    case 1168:
    case 1171:
    case 1180:
    case 1183:
    case 1186:
    case 1189:
    case 1192:
    case 1195:
    case 1198:
    case 1201:
    case 1240:
    case 1243:
    case 1246:
    case 1273:
    case 1276:
      return rainAndThunder;
    case 1066:
    case 1069:
    case 1072:
    case 1114:
    case 1117:
    case 1210:
    case 1213:
    case 1216:
    case 1219:
    case 1222:
    case 1225:
    case 1237:
    case 1249:
    case 1252:
    case 1255:
    case 1258:
    case 1261:
    case 1264:
    case 1279:
    case 1282:
      return snowIcon;
    default:
      return partlyCloudyDayIcon; // Default case for any other codes
  }
}