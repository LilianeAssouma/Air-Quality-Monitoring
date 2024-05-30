
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
  if (latestData != null && (latestData.mq9Value > 50 || latestData.mq7Value > 700)) {
    showAirPollutionAlert(context, latestData);
  }
}





// class SensorDataChart extends StatefulWidget {
//   @override
//   _SensorDataChartState createState() => _SensorDataChartState();
// }

// class _SensorDataChartState extends State<SensorDataChart> {
//   @override
//   void initState() {
//     super.initState();
//     fetchAndCheckAirPollutionData();
//   }

//   Future<void> fetchAndCheckAirPollutionData() async {
//     try {
//       final data = await fetchData();
//       checkAirPollutionLevels(context, data);
//     } catch (e) {
//       print('Failed to fetch air pollution data: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sensor Data Chart'),
//       ),
//       body: Center(
//         child: Text('Monitoring air quality...'),
//       ),
//     );
//   }
// }






















// import 'package:intl/intl.dart';
// import 'package:airquality_flutter_application/Component/TopNavigation/topNavBar.dart';

// import 'package:airquality_flutter_application/ServiceAPI/flutterAPI.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int temperature = 0;
//   String location = 'Kigali'; 
//   List<String> cities = ['Kigali']; 
//   List consolidatedWeatherList = []; 

//   @override
//   void initState() {
//     super.initState();
//   }

//   //Create a shader linear gradient
//   final Shader linearGradient = const LinearGradient(
//     colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
//   ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

//   @override
//   Widget build(BuildContext context) {
//     //Create a size variable for the media query
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: false,
//         titleSpacing: 0,
//         backgroundColor: Colors.white,
//         elevation: 0.0,
           
//         title:
//          Container(
//   padding: const EdgeInsets.only(left: 210),
//   width: size.width,
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center, 
//     children: [
//       //our location dropdown
//           Image.asset(
//             'assets/pin.png',
//             width: 20,
//           ),
//           const SizedBox(
//             width: 4,
//           ),
//           DropdownButtonHideUnderline(
//             child: DropdownButton(
//                 value: location,
//                 icon: const Icon(Icons.keyboard_arrow_down),
//                 items: cities.map((String location) {
//                   return DropdownMenuItem(
//                       value: location, child: Text(location));
//                 }).toList(),
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     location = newValue!;
//                   });
//                 }),
//           ),
//           const SizedBox(width: 20),
//         ],
//   ),
// ),

        
//       ),
      
//        drawer: MenuUtils.buildMenu(context),
//       body: Container(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
            
//            const Text(
//               "AirQuality",
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 20.0,
//               ),
//             ),
            
//             const SizedBox(
//               height: 50,
//             ),
//               Center(
//                 child: Align(
//                    alignment: Alignment.topCenter,
//                 child: Text(
//                 DateFormat('EEEE dd •').add_jm().format(DateTime.now()),
//                 style: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w300,
//                 ),
//               ),)
//             ),
             
//             Container(
//               width: size.width,
//               height: 250,
//               decoration: BoxDecoration(
                
//                   color: Color(0xffABCFF2),
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color(0xffABCFF2).withOpacity(.5),
//                       offset: const Offset(0, 25),
//                       blurRadius: 10,
//                       spreadRadius: -12,
//                     )
//                   ]),
//               child: Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   Positioned(
//                     top: -40,
//                     left: 15,
//                     child: Image.asset(
//                             'assets/wind.png',
//                             width: 150,
//                             height: 150,
//                           ),
//                   ),
//                   const Positioned(
//                     bottom: 30,
//                     left: 20,
//                     child: Text(
//                       "Stay Informed, Breathe Better,\nLive Healthier",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10,),
                   
         
//                   Positioned(
//                     top: 20,
//                     right: 20,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'o',
//                           style: TextStyle(
//                             fontSize: 40,
//                             fontWeight: FontWeight.bold,
//                             foreground: Paint()..shader = linearGradient,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             const SizedBox(
//               height: 50,
//             ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: AirQualityWidget(
//                  sensorDataFuture: fetchData(),
//            )
//               ),
//               ],
//         ),
//       ),
//     );
//   }