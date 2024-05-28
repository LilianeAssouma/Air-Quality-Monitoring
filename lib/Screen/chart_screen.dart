import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:airquality_flutter_application/ServiceAPI/flutterAPI.dart';



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
              title: Text('Sensor Data Chart'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                
                  SizedBox(
                    height: 250,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        minimum: 0,
                        maximum: 500, // Adjust maximum as needed
                        interval: 50, // Adjust interval as needed
                      ),
                      title: ChartTitle(text: 'Sensor Data for the Last 5 Readings'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(
                        enable: true,
                        header: '',
                        format: 'point.y', // Tooltip format
                      ),
                      series: <CartesianSeries>[
                        ColumnSeries<SensorData, int>(
                          dataSource: recentData,
                          xValueMapper: (SensorData data, _) => recentData.indexOf(data),
                          yValueMapper: (SensorData data, _) => data.mq9Value,
                          name: 'MQ9 Value',
                          pointColorMapper: (SensorData data, _) => getColorForAQI(data.mq9Value),
                        ),
                        ColumnSeries<SensorData, int>(
                          dataSource: recentData,
                          xValueMapper: (SensorData data, _) => recentData.indexOf(data),
                          yValueMapper: (SensorData data, _) => data.mq7Value,
                          name: 'MQ7 Value',
                          pointColorMapper: (SensorData data, _) => getColorForAQI(data.mq7Value),
                        ),
                        LineSeries<SensorData, int>(
                          dataSource: recentData,
                          xValueMapper: (SensorData data, _) => recentData.indexOf(data),
                          yValueMapper: (SensorData data, _) => data.temperature,
                          name: 'Temperature',
                          pointColorMapper: (SensorData data, _) => getColorForAQI(data.temperature.toInt()),
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
      },
    );
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
    } else {
      return Colors.brown;
    }
  }
}

