

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:airquality_flutter_application/Component/Hours/hours_list.dart';


  class HoursList extends StatelessWidget {
  const HoursList({Key? key}) : super(key: key);

   
  @override
  Widget build(BuildContext context) {
    final AQHoursList aqiHoursLists = Get.put(AQHoursList());
     
     return Material(
      type: MaterialType.transparency,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          const SizedBox(height: 100), 
           Column(
  children: [

    const Row(
      mainAxisAlignment:MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), 
          child: Text(
            "Hourly forecast",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), 
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 24,
          )
        ),
      ],
    ),
         
         const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Row(
                      children: List.generate(
                        aqiHoursLists.hourlyData.length,
                        (index) {
                          var hourData = aqiHoursLists.hourlyData[index];
                          DateTime dateTime = hourData.timestamp;
                          String formattedHour = DateFormat('HH').format(dateTime);

                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) => aqiHoursLists.onHoveredHourChanged(index),
                            onExit: (_) => aqiHoursLists.onHoveredHourChanged(null),
                            child: Material(
                              type: MaterialType.transparency,
                              child: GestureDetector(
                                onTap: () {
                                   aqiHoursLists.onHourSelected(index);
                                  //print('Hour $formattedHour tapped');
                                },
                                child: Obx(() => Container(
                                  margin: EdgeInsets.only(left: index == 0 ? 0 : 10),
                                  height: 140,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: aqiHoursLists.isSelected(index)
                                        ? Colors.blue
                                        : (aqiHoursLists.hoveredHour.value == index
                                            ? Colors.grey
                                            : Colors.white),
                                    borderRadius: BorderRadius.circular(35),
                                    border: Border.all(
                                      color: aqiHoursLists.isSelected(index)
                                          ? Colors.blue
                                          : (aqiHoursLists.hoveredHour.value == index
                                              ? Colors.grey
                                              : Colors.black),
                                      width: 2,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        hourData.iconPath,
                                        height: 60,
                                        width: 60,
                                      ),

                                      const SizedBox(height: 10),

                                      Text(
                                        formattedHour,
                                        style: TextStyle(
                                          color: aqiHoursLists.isSelected(index)
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}