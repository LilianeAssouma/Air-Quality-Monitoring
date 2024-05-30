import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:airquality_flutter_application/ServiceAPI/flutterAPI.dart';
import 'package:airquality_flutter_application/Component/TopNavigation/topNavBar.dart';


class SensorDataChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SensorData>>(
      future: fetchData(), // Fetch sensor data asynchronously
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<SensorData> sensorData = snapshot.data!;

          // Get 5 most recent sensor data points
          List<SensorData> recentData = sensorData.length >= 5
              ? sensorData.sublist(0, 5)
              : List<SensorData>.from(sensorData);

          return Scaffold(
            appBar: AppBar(
              title: Text('Sensor Data Readings'),
            ),
            drawer: MenuUtils.buildMenu(context),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 250,
                      child: SfCartesianChart(
                        primaryXAxis: DateTimeAxis(
                        intervalType: DateTimeIntervalType.minutes,
                        majorGridLines: MajorGridLines(width: 0),
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                        labelAlignment: LabelAlignment.center,
                        dateFormat: DateFormat.Hm(),
                        ),
                        primaryYAxis: const NumericAxis(
                          minimum: 0,
                          maximum: 500, // Adjust maximum as needed
                          interval: 50, // Adjust interval as needed
                        ),
                        legend: Legend(isVisible: true,),

                        tooltipBehavior: TooltipBehavior(
                          enable: true,
                          header: '',
                          format: 'point.y', // Tooltip format
                        ),
                        series: <CartesianSeries>[
                          ColumnSeries<SensorData, DateTime>(
                            dataSource: recentData,
                            xValueMapper: (SensorData data, _) => data.timestamp,
                            yValueMapper: (SensorData data, _) => data.mq9Value.toDouble(),
                            name: 'Methane',
                            pointColorMapper: (SensorData data, _) => getColorForAQI(data.mq9Value),
                          ),
                          ColumnSeries<SensorData, DateTime>(
                            dataSource: recentData,
                            xValueMapper: (SensorData data, _) => data.timestamp,
                            yValueMapper: (SensorData data, _) => data.mq7Value.toDouble(),
                            name: 'CO',
                            pointColorMapper: (SensorData data, _) => getColorForAQI(data.mq7Value),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                //    const Align(
                //       alignment: Alignment.center,
                //       child: const Text(
                //       'Risk Level Evaluation',
                //        style: const TextStyle(
                //   color: Colors.black,
                //   fontSize: 20,
                //   fontWeight: FontWeight.bold,
                // ),
                //     ),
                //     ),
                    SizedBox(height: 20),
                    BarchartDetails(sensorData: recentData),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  static Color getColorForAQI(int aqi) {
    if (aqi <= 100) {
      return Colors.green;
    } else if (aqi <= 200) {
      return Colors.yellow;
    } else if (aqi <= 10000) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}

class BarchartDetails extends StatelessWidget {
  final List<SensorData> sensorData;

  const BarchartDetails({required this.sensorData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: sensorData.map((sensorData) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Circular container for temperature
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffABCFF2), // Background color of the circle
                      ),
                      child: Center(
                        child: Text(
                          '${sensorData.temperature}°C', // Display the temperature
                          style: TextStyle(
                            color: Colors.white, // Text color
                            fontSize: 16, // Text size
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Time: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(sensorData.timestamp.toLocal())}', // Ensuring local timezone is used
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text('Temperature: ${sensorData.getTemperatureCategory()}'),
                          SizedBox(height: 4),
                          Text('Co Level: ${sensorData.mq9Value}PPM'),
                          Text('Carbon Monoxide: ${sensorData.getCoCategory()}'),
                          SizedBox(height: 8),
                          Text('MH4 Level: ${sensorData.mq7Value}PPM'),
                          Text('Methane: ${sensorData.getMh4Category()}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
