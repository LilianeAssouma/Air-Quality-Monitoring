
import 'package:airquality_flutter_application/Component/Hours/hours_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:airquality_flutter_application/MyData/my_data.dart';



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
  final List<AirQualityData> data = AirQualityData.generateSampleData();

  @override
  Widget build(BuildContext context) {
    final latestData = data.last; // Assuming the last data point is the latest

    return Scaffold(
      appBar: AppBar(
        title: Text('AQI Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overall AQI: ${latestData.airQualityIndex}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: latestData.color,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Contributions by Pollutants:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildPollutantRow('PM2.5', latestData.pm25, AirQualityData.getColorForAQI(latestData.pm25.toInt())),
            _buildPollutantRow('PM10', latestData.pm10, AirQualityData.getColorForAQI(latestData.pm10.toInt())),
            _buildPollutantRow('NO2', latestData.no2, AirQualityData.getColorForAQI(latestData.no2.toInt())),
            _buildPollutantRow('O3', latestData.o3, AirQualityData.getColorForAQI(latestData.o3.toInt())),
           const SizedBox(height: 16),
            const Text(
              'Health Effects Information:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildPollutantRow(String name, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$name:',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            value.toStringAsFixed(2),
            style: TextStyle(fontSize: 16, color: color),
          ),
        ],
      ),
    );
  }

  


}








