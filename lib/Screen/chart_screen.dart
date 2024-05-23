import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:airquality_flutter_application/MyData/my_data.dart';

class Pollutant {
  final String name;
  final double value;
  final Color color;

  Pollutant({required this.name, required this.value, required this.color});
}

class HourlyAirQualityChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    List<AirQualityData> hourlyData = AirQualityData.generateSampleData();
    
    DateTime now = DateTime.now();
    int currentHour = now.hour;

    // Filter data to include 2 hours before and 2 hours after the current hour
    List<AirQualityData> filteredData = hourlyData.where((data) {
      int hour = data.timestamp.hour;
      return (hour >= currentHour - 2) && (hour <= currentHour + 2);
    }).toList();

    // Define pollutants for the current hour 
    AirQualityData currentData = filteredData.first;

    List<Pollutant> pollutants = [
      Pollutant(name: 'PM2.5', value: currentData.pm25, color: AirQualityData.getColorForAQI(currentData.pm25.toInt())),
      Pollutant(name: 'PM10', value: currentData.pm10, color: AirQualityData.getColorForAQI(currentData.pm10.toInt())),
      Pollutant(name: 'NO2', value: currentData.no2, color: AirQualityData.getColorForAQI(currentData.no2.toInt())),
      Pollutant(name: 'O3', value: currentData.o3, color: AirQualityData.getColorForAQI(currentData.o3.toInt())),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Hourly Air Quality Chart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: pollutants.map((pollutant) => Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: pollutant.color,
                    ),
                    padding:const EdgeInsets.all(8.0),
                    child: Text(
                      '${pollutant.value.toStringAsFixed(1)}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    pollutant.name,
                    style:const  TextStyle(fontSize: 12.0),
                    textAlign: TextAlign.center,
                  ),
                ],
              )).toList(),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 250, 
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(
                  minimum: 0,
                  maximum: 500, // Adjust maximum as needed
                  interval: 50,  // Adjust interval as needed
                ),
                title: ChartTitle(text: 'Air Quality for the Next 5 Hours'),
                legend: Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  header: '', 
                  format: 'point.y AQI', // Tooltip format
                ),
                series: <CartesianSeries>[
                  ColumnSeries<AirQualityData, String>(
                    dataSource: filteredData,
                    xValueMapper: (AirQualityData data, _) => '${data.timestamp.hour}:00',
                    yValueMapper: (AirQualityData data, _) => data.pm25,
                    name: 'PM2.5',
                    pointColorMapper: (AirQualityData data, _) => AirQualityData.getColorForAQI(data.pm25.toInt()),
                    enableTooltip: true,
                  ),
                  ColumnSeries<AirQualityData, String>(
                    dataSource: filteredData,
                    xValueMapper: (AirQualityData data, _) => '${data.timestamp.hour}:00',
                    yValueMapper: (AirQualityData data, _) => data.pm10,
                    name: 'PM10',
                    pointColorMapper: (AirQualityData data, _) => AirQualityData.getColorForAQI(data.pm10.toInt()),
                    enableTooltip: true,
                  ),
                  ColumnSeries<AirQualityData, String>(
                    dataSource: filteredData,
                    xValueMapper: (AirQualityData data, _) => '${data.timestamp.hour}:00',
                    yValueMapper: (AirQualityData data, _) => data.no2,
                    name: 'NO2',
                    pointColorMapper: (AirQualityData data, _) => AirQualityData.getColorForAQI(data.no2.toInt()),
                    enableTooltip: true,
                  ),
                  ColumnSeries<AirQualityData, String>(
                    dataSource: filteredData,
                    xValueMapper: (AirQualityData data, _) => '${data.timestamp.hour}:00',
                    yValueMapper: (AirQualityData data, _) => data.o3,
                    name: 'O3',
                    pointColorMapper: (AirQualityData data, _) => AirQualityData.getColorForAQI(data.o3.toInt()),
                    enableTooltip: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), 
            Text(
              'Additional information or controls can be placed here.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}






// class HourlyAirQualityChart extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Sample hourly data
//     List<AirQualityData> hourlyData = AirQualityData.generateSampleData();
//     // Get the current hour
//     DateTime now = DateTime.now();
//     int currentHour = now.hour;

//     // Filter data to include 2 hours before and 2 hours after the current hour
//     List<AirQualityData> filteredData = hourlyData.where((data) {
//       int hour = data.timestamp.hour;
//       return (hour >= currentHour - 2) && (hour <= currentHour + 2);
//     }).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Hourly Air Quality Chart'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 250, // Adjust the height as needed
//               child: SfCartesianChart(
//                 primaryXAxis: CategoryAxis(),
//                 primaryYAxis: NumericAxis(
//                   minimum: 0,
//                   maximum: 500, // Adjust maximum as needed
//                   interval: 50,  // Adjust interval as needed
//                 ),
//                 title: ChartTitle(text: 'Air Quality for the Next 5 Hours'),
//                 legend: Legend(isVisible: true),
//                 tooltipBehavior: TooltipBehavior(
//                   enable: true,
//                   header: '', // Hide the header if not needed
//                   format: 'point.y AQI', // Tooltip format
//                 ),
//                 series: <CartesianSeries>[
//                   ColumnSeries<AirQualityData, String>(
//                     dataSource: filteredData,
//                     xValueMapper: (AirQualityData data, _) => '${data.timestamp.hour}:00',
//                     yValueMapper: (AirQualityData data, _) => data.pm25,
//                     name: 'PM2.5',
//                     pointColorMapper: (AirQualityData data, _) => AirQualityData.getColorForAQI(data.pm25.toInt()),
//                     enableTooltip: true,
//                   ),
//                   ColumnSeries<AirQualityData, String>(
//                     dataSource: filteredData,
//                     xValueMapper: (AirQualityData data, _) => '${data.timestamp.hour}:00',
//                     yValueMapper: (AirQualityData data, _) => data.pm10,
//                     name: 'PM10',
//                     pointColorMapper: (AirQualityData data, _) => AirQualityData.getColorForAQI(data.pm10.toInt()),
//                     enableTooltip: true,
//                   ),
//                   ColumnSeries<AirQualityData, String>(
//                     dataSource: filteredData,
//                     xValueMapper: (AirQualityData data, _) => '${data.timestamp.hour}:00',
//                     yValueMapper: (AirQualityData data, _) => data.no2,
//                     name: 'NO2',
//                     pointColorMapper: (AirQualityData data, _) => AirQualityData.getColorForAQI(data.no2.toInt()),
//                     enableTooltip: true,
//                   ),
//                   ColumnSeries<AirQualityData, String>(
//                     dataSource: filteredData,
//                     xValueMapper: (AirQualityData data, _) => '${data.timestamp.hour}:00',
//                     yValueMapper: (AirQualityData data, _) => data.o3,
//                     name: 'O3',
//                     pointColorMapper: (AirQualityData data, _) => AirQualityData.getColorForAQI(data.o3.toInt()),
//                     enableTooltip: true,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20), // Space between chart and other content
//             // Additional content can be added here
//             Text(
//               'Add',
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }