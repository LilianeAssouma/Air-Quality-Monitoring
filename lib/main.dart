
import 'package:airquality_flutter_application/Component/Recommandation&Details/healthProfile.dart';
import 'package:airquality_flutter_application/Screen/chart_screen.dart';

import 'package:airquality_flutter_application/Screen/intro_screen.dart';
import 'package:airquality_flutter_application/Screen/second_screen.dart';
import 'package:airquality_flutter_application/Screen/alertMessage.dart';
import 'package:flutter/material.dart';
import 'package:airquality_flutter_application/Screen/home_screen.dart';


void main() {
 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Air Quality App',
      initialRoute: '/home',
      routes: {
        '/':(context) =>IntroScreen(),
        '/home':(context) => HomeScreen(),
        '/hours':(context) => HoursGaugescreen(),
        '/health': (context) => HealthEffectsPage(),
        '/chart':(context) =>SensorDataChart(),
        
      },
    );
  }
}