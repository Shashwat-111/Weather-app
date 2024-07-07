import 'package:flutter/material.dart';

class WeatherDetailsBox extends StatelessWidget {
  const WeatherDetailsBox({
    super.key,
    required this.defaultColor,
    required this.blackIcon,
    required this.whiteIcon,
    required this.displayText,
    required this.value,
    required this.isDay,
    required this.sign,
  });

  final Color defaultColor;
  final String blackIcon;
  final String whiteIcon;
  final String displayText;
  final dynamic value;
  final int isDay;
  final String sign;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(isDay == 1 ? blackIcon : whiteIcon),
            const SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$value$sign",
                  style: TextStyle(color: defaultColor),
                ),
                Text(
                  displayText,
                  style: TextStyle(color: defaultColor),
                )
              ],
            )
          ],
        ));
  }
}
