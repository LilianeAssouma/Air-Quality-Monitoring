
import 'package:flutter/material.dart';
import 'package:airquality_flutter_application/ServiceAPI/flutterAPI.dart';


void showAirPollutionAlert(BuildContext context, SensorData data) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Air Pollution Alert'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Carbon Monoxide Level: ${data.mq9Value}'),
            Text('Category: ${data.getCoCategory()}'),
            SizedBox(height: 8),
            Text('Methane Level: ${data.mq7Value}'),
            Text('Category: ${data.getMh4Category()}'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}



// Function to Check Air Pollution Levels

void checkAirPollutionLevels(BuildContext context, List<SensorData> data) {
  final latestData = data.isNotEmpty ? data.first : null;
  if (latestData != null && (latestData.mq9Value > 150 || latestData.mq7Value > 700)) {
    showAirPollutionAlert(context, latestData);
  }
}



