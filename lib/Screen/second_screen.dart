
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:airquality_flutter_application/Component/TopNavigation/topNavBar.dart';
import 'package:airquality_flutter_application/Component/Hours/hoursCtrl.dart';
import 'package:airquality_flutter_application/MyData/my_data.dart';
import 'package:airquality_flutter_application/Component/Hours/hours_list.dart';

import 'dart:ui'; // Import ImageFilter

class HoursGaugescreen extends StatelessWidget {

 Widget build(BuildContext context) {

   final AQHoursList aqiHoursLists = Get.put(AQHoursList());

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title:const Text('Air Quality Forecast'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      drawer: MenuUtils.buildMenu(context),
      body: Stack(
          children: [
            Align(
              alignment:const AlignmentDirectional(3, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration:const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 3, 67, 120),
                ),
              ),
            ),
            Align(
              alignment:const AlignmentDirectional(-3, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration:const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 3, 62, 110),
                ),
              ),
            ),
            Align(
              alignment:const AlignmentDirectional(0, -1.2),
              child: Container(
                height: 300,
                width: 600,
                decoration:const BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
              child: Container(
                decoration:const BoxDecoration(color: Colors.transparent),
              ),
            ),
           const SizedBox(height: 20,),
            Positioned.fill(
            child: Column(
              children: [
                const SizedBox(height: 20),
                //AirQualityGauge(airQualityData: aqiHoursLists.selectedAirQualityData),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                     AirQualityGauge(airQualityData: aqiHoursLists.selectedAirQualityData),
                      RecommendationDisplay(), // Adding RecommendationDisplay
                      const Padding(
                        padding: EdgeInsets.only(bottom: 50),
                        child: HoursList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}










class AirQualityGauge extends StatelessWidget {
   final Rx<AirQualityData?> airQualityData; 

  AirQualityGauge({required this.airQualityData});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        child: Obx(() => airQualityData.value != null
            ? SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 300,
              ranges: <GaugeRange>[
                GaugeRange(startValue: 0, endValue: 50, color: Colors.green,startWidth: 20,
                  endWidth: 20,),
                GaugeRange(startValue: 50, endValue: 100, color: Colors.yellow,startWidth: 20,
                  endWidth: 20,),
                GaugeRange(startValue: 100, endValue: 150, color: Colors.orange,startWidth: 20,
                  endWidth: 20,),
                GaugeRange(startValue: 150, endValue: 200, color: Colors.red,startWidth: 20,
                  endWidth: 20,),
                GaugeRange(startValue: 200, endValue: 300, color: Colors.purple,startWidth: 20,
                  endWidth: 20,),
              ],
              pointers: <GaugePointer>[
              NeedlePointer(
                value: airQualityData.value!.airQualityIndex.toDouble(), // Accessing value of Rx variable
                        needleColor: airQualityData.value!.color,
              ),

            ],
              axisLineStyle:const AxisLineStyle(
                thickness: 20,
                color: Colors.transparent,
              ),
              majorTickStyle: MajorTickStyle(length: 0), // Hides major ticks
              minorTickStyle: MinorTickStyle(length: 0),
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  widget: Container(
                    child: Text(
                      airQualityData.value!.airQualityIndex.toString(),
                      style: TextStyle(
                        fontSize: 25,
                        color: airQualityData.value!.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  angle: 90,
                  positionFactor: 0.5,
                ),
              ],
            ),
          ],
        )
        : Container()),
      ),
    );
  }
}

















class RecommendationDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AQHoursList aqHoursList = Get.put(AQHoursList());

    return Obx(() {
      final selectedData = aqHoursList.selectedAirQualityData.value;

      // Check if selectedData is not null before accessing its recommendation
      final recommendation = selectedData?.recommendation ?? 'No recommendation available';

      return Column(
        children: [
          Text(
            recommendation,
            style: TextStyle(fontSize: 16.0,color: Colors.white),
            textAlign: TextAlign.center,
          ),
          
        ],
      );
    });
  }
}