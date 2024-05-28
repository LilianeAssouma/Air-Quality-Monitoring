import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<List<SensorData>> fetchData() async {
  final response = await http.get(Uri.parse('http://172.31.213.161:3000/sensor-data'));
  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    return list.map((model) => SensorData.fromJson(model)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}




class SensorData {
  final DateTime timestamp;
  final int mq9Value;
  final int mq7Value;
  final double temperature;
  final double? latitude;
  final double? longitude;

  SensorData.fromJson(Map<String, dynamic> json)
      : timestamp = DateTime.parse(json['timestamp']),
        mq9Value = json['mq9_value'],
        mq7Value = json['mq7_value'],
        temperature = json['temperature'].toDouble(),
        latitude = json['latitude']?.toDouble(),
        longitude = json['longitude']?.toDouble();



        String getCoImage() {
    return 'assets/carbon-monoxide.png'; // Simplified for this example
  }

  String getCoCategory() {
    if (mq9Value <= 50) {
      return 'Good';
    } else if (mq9Value <= 100) {
      return 'Moderate';
    } else if (mq9Value <= 150) {
      return 'Unhealthy for Sensitive Groups';
    } else if (mq9Value <= 200) {
      return 'Unhealthy';
    } else if (mq9Value <= 300) {
      return 'Very Unhealthy';
    } else {
      return 'Hazardous';
    }
  }

  String getMh4Image() {
    return 'assets/methane.png'; // Simplified for this example
  }

  String getMh4Category() {
    if (mq7Value <= 50) {
      return 'Good';
    } else if (mq7Value <= 100) {
      return 'Moderate';
    } else if (mq7Value <= 150) {
      return 'Unhealthy for Sensitive Groups';
    } else if (mq7Value <= 200) {
      return 'Unhealthy';
    } else if (mq7Value <= 300) {
      return 'Very Unhealthy';
    } else {
      return 'Hazardous';
    }
  }

  String getTemperatureImage() {
    return 'assets/7.png'; // Simplified for this example
  }

  String getTemperatureCategory() {
    if (temperature <= 20) {
      return 'Cold';
    } else if (temperature <= 30) {
      return 'Warm';
    } else {
      return 'Hot';
    }
  }
}




