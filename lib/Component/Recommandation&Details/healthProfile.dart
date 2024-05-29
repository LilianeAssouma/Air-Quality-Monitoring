

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
            pollutantDetailsCard(pollutant: 'Carbon Monoxide', healthEffects: [
              '0-95 ppm: Generally considered safe for healthy adults.',
              '95-200 ppm: May cause mild headaches, nausea, dizziness, and fatigue after several hours of exposure.',
              '200-500 ppm: Can cause headaches, nausea, vomiting, and confusion within 2-3 hours.',
              '500-1500 ppm: Can lead to disorientation, drowsiness, and loss of coordination within 1-2 hours.',
              '1500-4000 ppm: Can cause severe headaches, weakness, vomiting, and collapse within 15-30 minutes.',
              '4000+ ppm: Can be fatal within minutes.',
            ], learnMoreUrl: 'https://www.osha.gov/sites/default/files/publications/carbonmonoxide-factsheet.pdf'),
            pollutantDetailsCard(pollutant: 'Methane', healthEffects: [
              'Below 1000 ppm: Generally considered unlikely to cause health effects in healthy adults for short-term exposure.',
              '1000-5000 ppm: May cause headaches, nausea, and dizziness with prolonged exposure.',
              '5000-10,000 ppm: Can lead to asthmatic symptoms, difficulty breathing, and impaired coordination.',
              'Above 10,000 ppm: Risk of suffocation increases significantly.',
            ], learnMoreUrl: 'https://minearc.com/methane-health-and-safety-hazards-fact-sheet/'),
            
                    pollutantDetailsCard(pollutant: 'Temperature', healthEffects: [
              'Below 15°C: Can lead to shivering, decreased circulation, and eventually hypothermia in prolonged exposure.',
              '15-25°C: Generally considered a comfortable temperature range for most people.',
              '25-35°C: Can cause discomfort, sweating, and increased risk of heat exhaustion in prolonged exposure.',
              'Above 35°C: Can lead to heatstroke, which is a serious medical condition with potential for organ damage or death.',
            ], learnMoreUrl: 'https://minearc.com/methane-health-and-safety-hazards-fact-sheet/'),
            const SizedBox(height: 10),
             const Text(
              'Temperature Effects on Health:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
           
            const Text(
              'Empowering Informed Decisions:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              'By understanding the health effects of air pollutants, you can make informed decisions about your activities based on air quality data. Here\'s how:',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 15),
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




