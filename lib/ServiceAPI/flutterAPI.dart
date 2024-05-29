import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<List<SensorData>> fetchData() async {
  final response = await http.get(Uri.parse('http://192.168.1.116:3000/sensor-data'));
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
    if (mq9Value <= 95) {
      return 'Generally considered safe for healthy adults.';
    } else if (mq9Value <= 200) {
      return ' May cause mild headaches, nausea, dizziness, and fatigue after several hours of exposure.';
    } else if (mq9Value <= 150) {
      return 'Unhealthy for Sensitive Groups';
    } else if (mq9Value <= 500) {
      return 'Can cause headaches, nausea, vomiting, and confusion within 2-3 hours.';
    } else if (mq9Value <= 1500) {
      return 'Can lead to disorientation, drowsiness, and loss of coordination within 1-2 hours.';
    } else if(mq9Value <=4000){
       return 'Can cause severe headaches, weakness, vomiting, and collapse within 15-30 minutes.';
    }
    else {
      return 'Can be fatal within minutes.';
    }
  }



  String getMh4Image() {
    return 'assets/methane.png'; // Simplified for this example
  }

  String getMh4Category() {
    if (mq7Value <= 1000) {
      return 'Generally considered unlikely to cause health effects in healthy adults for short-term exposure.';
    } else if (mq7Value <= 5000) {
      return 'May cause headaches, nausea, and dizziness with prolonged exposure';
    } else if (mq7Value <= 10000) {
      return 'Can lead to asthmatic symptoms, difficulty breathing, and impaired coordination.';
    }  else {
      return 'Risk of suffocation increases significantly.';
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




