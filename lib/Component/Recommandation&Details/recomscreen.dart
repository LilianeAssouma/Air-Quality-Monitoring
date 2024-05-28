
import 'package:airquality_flutter_application/Component/Hours/hours_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:airquality_flutter_application/ServiceAPI/flutterAPI.dart';



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



class AirQualityDetailPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('AQI Details'),
        leading: IconButton(
          icon:const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
      body: FutureBuilder<List<SensorData>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final sensorDataList = snapshot.data!;
            final latestData = sensorDataList.last;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Temperature: ${latestData.temperature} °C',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'CO: ${latestData.mq9Value}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Methane: ${latestData.mq7Value}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 50),
                  const Text(
                    'Health Effects Information:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
