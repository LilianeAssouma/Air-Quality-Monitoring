import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:airquality_flutter_application/ServiceAPI/flutterAPI.dart';
import 'package:airquality_flutter_application/MyData/my_data.dart';


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
                      title: ChartTitle(text: 'Sensor Data Readings'),
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
                    'AQI Details',
                    style: TextStyle(fontSize: 16),
                  ),
                  FutureBuilder<List<SensorData>>(
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
                    'Latest Temperature: ${latestData.temperature} °C - ${latestData.getTemperatureCategory()}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Latest CO Level: ${latestData.mq9Value} PPM - ${latestData.getCoCategory()}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                   Text(
                    'Latest Methane Level: ${latestData.mq7Value} PPM - ${latestData.getMh4Category()}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  
                  SizedBox(height: 8),
                ],
              ),
            );
          }
        },
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



