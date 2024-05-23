

import 'package:flutter/material.dart';


class AirQualityData {
  final DateTime timestamp;
  final double pm25;
  final double pm10;
  final double no2;
  final double o3;
  final int airQualityIndex;
  final String airQualityStatus;
  final String iconPath;
  final Color color;
  final DateTime date;
 final String recommendation;

  AirQualityData({
    required this.timestamp,
    required this.pm25,
    required this.pm10,
    required this.no2,
    required this.o3,
    required this.airQualityIndex,
    required this.airQualityStatus,
    required this.iconPath,
    required this.color,
    required this.date,
    required this.recommendation,
  });

  static String determineAirQualityIndex(int aqi) {
    if (aqi <= 50) {
      return 'Good';
    } else if (aqi <= 100) {
      return 'Moderate';
    } else if (aqi <= 150) {
      return 'Unhealthy';
    } else if (aqi <= 200) {
      return 'Unhealthy';
    } else if (aqi <= 300) {
      return 'Unhealthy';
    } else {
      return 'Hazardous';
    }
  }

  static String getPollutantIconPath(int aqi) {
    if (aqi <= 50) {
      return 'assets/1.png';
    } else if (aqi <= 100) {
      return 'assets/12.png';
    } else if (aqi <= 150) {
      return 'assets/3.png';
    } else if (aqi <= 200) {
      return 'assets/1.png';
    } else if (aqi <= 300) {
      return 'assets/8.png';
    } else {
      return 'assets/6.png';
    }
  }

  static Color getColorForAQI(int aqi) {
    if (aqi <= 50) {
      return Colors.green;
    } else if (aqi <= 100) {
      return Colors.yellow;
    } else if (aqi <= 150) {
      return Colors.orange;
    } else if (aqi <= 200) {
      return Colors.red;
    } else if (aqi <= 300) {
      return Colors.purple;
    } else {
      return Colors.brown;
    }
  }
  
  static String getRecommendationForAQI(int aqi) {
  if (aqi <= 50) {
    return 'Air quality is good. Enjoy outdoor activities!';
  } else if (aqi <= 100) {
    return 'moderate,Limit outdoor activities if you are sensitive to air pollution.';
  } else {
    return 'unhealthy,Avoid prolonged outdoor exertion.';
  }
}

  static List<AirQualityData> generateSampleData() {
    return List<AirQualityData>.generate(24, (hour) {
       final pm25 = hour * 13.5 + 10;
      final pm10 = hour * 7.0 + 5;
      final no2 = hour * 5.0 + 3;
      final o3 = hour * 2.0 + 1;
      final aqi = (pm25 + pm10 + no2 + o3).toInt(); //  AQI calculation

      final aqiStatus = determineAirQualityIndex(aqi);
      final iconPath = getPollutantIconPath(aqi);
      final color = getColorForAQI(aqi);
      final recommendation = getRecommendationForAQI(aqi);

      return AirQualityData(
        timestamp: DateTime.now().add(Duration(hours: hour)),
        pm25: pm25,
        pm10: pm10,
        no2: no2,
        o3: o3,
        airQualityIndex: aqi,
        airQualityStatus: aqiStatus,
        iconPath: iconPath,
        color: color,
        date: DateTime.now(),
        recommendation: recommendation,
      );
    });
  }
  Color getColor() {
    return getColorForAQI(airQualityIndex);
  }
}
