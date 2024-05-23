import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:airquality_flutter_application/MyData/my_data.dart';
import 'package:airquality_flutter_application/Component/TopNavigation/topNavBar.dart';


class HomeScreen extends StatelessWidget {
final TextEditingController _searchController = TextEditingController();

  HomeScreen({Key? key}) : super(key: key);
  
 @override
  Widget build(BuildContext context) {
    List<AirQualityData> sampleData = AirQualityData.generateSampleData();
    int currentHour = DateTime.now().hour;
    AirQualityData currentData = sampleData[currentHour];

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss the keyboard
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: SearchAppBar(
          title: 'Home',
          searchController: _searchController,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
          ),
        ),
        drawer: MenuUtils.buildMenu(context),
        body: SingleChildScrollView(
          physics:const ClampingScrollPhysics(),
       child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(3, -0.3),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 3, 67, 120),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-3, -0.3),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 3, 62, 110),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, -1.2),
                  child: Container(
                    height: 300,
                    width: 600,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.transparent),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                       const Center(
                        child:Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '📍KN 126 St, Kigali',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),

                        ) 
                      ),
                       const SizedBox(height: 15),
                       const Center(
                        child: Text(
                          'Current AQI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                       const SizedBox(height: 5),
                      Center(
                        child: Text(
                          DateFormat('EEEE dd •').add_jm().format(currentData.date),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                     
                      const SizedBox(height: 15),
                      Center(
  child: Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.blue.withOpacity(0.2),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              currentData.iconPath,
              height: 130,
              width: 130,
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${currentData.airQualityIndex}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    currentData.airQualityStatus.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            currentData.recommendation,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    ),
  ),
),

          
                      const SizedBox(height: 50),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: AirQualityWidgets(data: sampleData),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      )
    );
  }
}







//search widget 

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final TextEditingController searchController;
  final Color backgroundColor;
  final SystemUiOverlayStyle systemOverlayStyle;
  final Color iconColor;
  final double iconSize; // Add iconSize parameter

  SearchAppBar({
    required this.title,
    required this.searchController,
    this.backgroundColor = Colors.transparent,
    this.systemOverlayStyle = const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ),
    this.iconColor = Colors.white, // Default icon color
    this.iconSize = 24.0, // Default icon size
  });

  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor,
      elevation: 0,
      systemOverlayStyle: widget.systemOverlayStyle,
      title: _isSearching
          ? TextField(
              controller: widget.searchController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
              style:const TextStyle(color: Colors.white),
            )
          : Text(widget.title),
      actions: [
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: widget.iconColor,
              size: widget.iconSize, // Use iconSize parameter
            ),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  widget.searchController.clear();
                }
              });
            },
        ),
      ],
    );
  }
}







class AirQualityWidgets extends StatelessWidget {
  final List<AirQualityData> data;

  const AirQualityWidgets({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentHour = DateTime.now().hour;
    AirQualityData currentData = data[currentHour];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              print('Button clicked!');
              Navigator.pushReplacementNamed(context, '/view');
            },
            child: const Text('View more!'),
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            height: 150, // Adjust the height as needed
            child: Row(
              children: [
                buildColumn(currentData.pm25, 'PM2.5', currentData.pm25.toInt()),
                buildColumn(currentData.pm10, 'PM10', currentData.pm10.toInt()),
                buildColumn(currentData.no2, 'NO2', currentData.no2.toInt()),
                buildColumn(currentData.o3, 'Ozone', currentData.o3.toInt()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildColumn(double value, String title, int airQualityIndex) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            AirQualityData.getPollutantIconPath(value.toInt()),
            scale: 8,
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title\n${value.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Text(
                AirQualityData.determineAirQualityIndex(airQualityIndex),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
