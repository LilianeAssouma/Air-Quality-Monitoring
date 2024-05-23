

import 'package:flutter/material.dart';


class HealthEffectsPage extends StatelessWidget {
  const HealthEffectsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Effects Information'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Understanding Health Effects of Air Pollutants',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Air pollution is a mixture of particles and gases in the air. It can come from many sources, such as car emissions, factories, and wildfires. Exposure to air pollution can have a number of negative health effects, both short-term and long-term.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            const Text(
              'Common Air Pollutants and Health Impacts:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(thickness: 1),
            pollutantDetailsCard(pollutant: 'PM2.5', healthEffects: [
              'Respiratory problems, including coughing, wheezing, and shortness of breath.',
              'Increased risk of heart disease, stroke, and lung cancer.',
            ], learnMoreUrl: 'https://www.epa.gov/pm2/health-effects-pm25'),
            pollutantDetailsCard(pollutant: 'PM10', healthEffects: [
              'Similar health effects as PM2.5, but generally less severe.',
              'Can irritate the eyes, nose, and throat.',
            ], learnMoreUrl: 'https://www.epa.gov/pm2/health-effects-pm10'),
            pollutantDetailsCard(pollutant: 'Ozone (O3)', healthEffects: [
              'Respiratory problems, including coughing, wheezing, and chest tightness.',
              'Reduced lung function.',
              'Increased risk of asthma attacks.',
            ], learnMoreUrl: 'https://www.epa.gov/ground-level-ozone-pollution/health-effects-ozone-pollution'),
            pollutantDetailsCard(pollutant: 'Nitrogen Dioxide (NO2)', healthEffects: [
              'Respiratory problems, including coughing, wheezing, and shortness of breath.',
              'Can irritate the lungs.',
              'May contribute to asthma development.',
            ], learnMoreUrl: 'https://www.epa.gov/no2-pollution/health-effects-no2-pollution'),
            const SizedBox(height: 10),
            const Text(
              'Empowering Informed Decisions:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              'By understanding the health effects of air pollutants, you can make informed decisions about your activities based on air quality data. Here\'s how:',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 15),
            const Text('- When air quality is good (AQI <= 50), you can enjoy outdoor activities without worry.'),
            const Text('- When air quality is moderate (AQI <= 100), you may want to limit strenuous outdoor activities, especially if you have respiratory problems.'),
            const Text('- When air quality is unhealthy (AQI > 100), it\'s best to avoid prolonged outdoor exertion and stay indoors as much as possible, especially for sensitive individuals.'),
            const SizedBox(height: 10),
            const Text(
              'Identifying Dominant Pollutants:',              
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Air quality data often includes information on specific pollutants like PM2.5, PM10, etc. By knowing which pollutants are driving the overall AQI, you can take targeted precautions.',
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

 Widget pollutantDetailsCard({
  required String pollutant,
  required List<String> healthEffects,
  required String learnMoreUrl,
}) {
  return Card(
    elevation: 4,
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pollutant,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: healthEffects.map((effect) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text('• $effect'),
              );
            }).toList(),
          ),
          SizedBox(height: 8),
          InkWell(
            onTap: () {
              // Implement navigation to learn more page
              
              
            },
            child: Text(
              'Learn more',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    ),
  );
}
}