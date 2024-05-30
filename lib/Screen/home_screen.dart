
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:airquality_flutter_application/Component/TopNavigation/topNavBar.dart';
import 'package:airquality_flutter_application/ServiceAPI/flutterAPI.dart';
import 'package:airquality_flutter_application/Screen/alertMessage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int temperature = 0;
  String location = 'Kigali'; 
  List<String> cities = ['Kigali']; 
  List consolidatedWeatherList = []; 
  late List<SensorData> sensorData;

  void checkAirPollution() {
  if (sensorData.isNotEmpty) {
    final latestData = sensorData.first;
    if (latestData.mq9Value > 350 || latestData.mq7Value > 700) {
      showAirPollutionAlert(context, latestData);
    }
  }
}

  @override
void initState() {
  super.initState();
  fetchData().then((data) {
    setState(() {
      sensorData = data;
      checkAirPollutionLevels(context, sensorData); //air pollution levels after fetching data
    });
  });
}

  //Create a shader linear gradient
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    //Create a size variable for the media query
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0.0,
           
        title:
         Container(
  padding: const EdgeInsets.only(left: 210),
  width: size.width,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center, 
    children: [
      //our location dropdown
          Image.asset(
            'assets/pin.png',
            width: 20,
          ),
          const SizedBox(
            width: 4,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton(
                value: location,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: cities.map((String location) {
                  return DropdownMenuItem(
                      value: location, child: Text(location));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    location = newValue!;
                  });
                }),
          ),
          const SizedBox(width: 20),
        ],
  ),
),

        
      ),
      
       drawer: MenuUtils.buildMenu(context),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
           const Text(
              "AirQuality",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
            
            const SizedBox(
              height: 50,
            ),
              Center(
                child: Align(
                   alignment: Alignment.topCenter,
                child: Text(
                DateFormat('EEEE dd •').add_jm().format(DateTime.now()),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),)
            ),
             
            Container(
              width: size.width,
              height: 250,
              decoration: BoxDecoration(
                
                  color: Color(0xffABCFF2),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffABCFF2).withOpacity(.5),
                      offset: const Offset(0, 25),
                      blurRadius: 10,
                      spreadRadius: -12,
                    )
                  ]),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -40,
                    left: 15,
                    child: Image.asset(
                            'assets/wind.png',
                            width: 150,
                            height: 150,
                          ),
                  ),
                  const Positioned(
                    bottom: 30,
                    left: 20,
                    child: Text(
                      "Stay Informed, Breathe Better,\nLive Healthier",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                   
         
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'o',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = linearGradient,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(
              height: 50,
            ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AirQualityWidget(
                 sensorDataFuture: fetchData(),
           )
              ),
              ],
        ),
      ),
    );
  }
}






class AirQualityWidget extends StatelessWidget {
  final Future<List<SensorData>> sensorDataFuture;

  const AirQualityWidget({Key? key, required this.sensorDataFuture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SensorData>>(
      future: sensorDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          final latestData = snapshot.data!.last;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/chart');
                  },
                  child: const Text('View more!'),
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    airQualityItem(
                      text: 'Temperature',
                      value:  latestData.temperature.round(),
                      unit: '°C',
                      imagePath: latestData.getTemperatureImage(),
                    ),
                    const SizedBox(width: 10),
                    airQualityItem(
                      text: 'CO',
                      value: latestData.mq9Value.round(), // Round for consistency
                      unit: '',
                      imagePath: latestData.getCoImage(),
                    ),
                    const SizedBox(width: 10),
                    airQualityItem(
                      text: 'Methane',
                      value: latestData.mq7Value.round(), // Round for consistency
                      unit: '',
                      imagePath: latestData.getMh4Image(),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget airQualityItem({
    required String text,
    required int value,
    required String unit,
    required String imagePath,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 5),
          Text(
            '$text: $value $unit',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}













   //        FutureBuilder<List<SensorData>>(
            //   future: fetchData(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return CircularProgressIndicator();
            //     } else if (snapshot.hasError) {
            //       return Text('Error: ${snapshot.error}');
            //     } else {
            //       SensorData? latestData = snapshot.data?.firstOrNull;
            //       if (latestData != null) {
            //         String temperatureCategory = latestData.getTemperatureCategory();
            //         return Text(
            //           'Temperature: $temperatureCategory',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 16,
            //           ),
            //         );
            //       } else {
            //         return Text(
            //           'No temperature data available',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 16,
            //           ),
            //         );
            //       }
            //     }
            //   },
            // ),