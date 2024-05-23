

import 'package:get/get.dart';
import 'package:airquality_flutter_application/MyData/my_data.dart';

class AQHoursList extends GetxController {
  final List<AirQualityData> hourlyData = [];
  final RxInt selectedIndex = (-1).obs;  // Tracks the selected hour index
  final hoveredHour = Rxn<int>();  // Tracks the hovered hour
  final selectedAirQualityData = Rxn<AirQualityData>(); 
  

  @override
  void onInit() {
    super.onInit();
    _generateHourlyData();

      if (hourlyData.isNotEmpty) {
        // selectedAirQualityData.value = hourlyData.first;
      selectedAirQualityData.value = hourlyData.firstWhere(
        (data) => DateTime.now().hour == data.timestamp.hour,
        orElse: () => hourlyData.first,
      );
      selectedIndex.value = hourlyData.indexWhere(
        (data) => DateTime.now().hour == data.timestamp.hour,
      );
    }
  }


 void _generateHourlyData() {
  hourlyData.addAll(AirQualityData.generateSampleData());
  // hourlyData.forEach((data) {                               
  //     print('Generated data: ${data.timestamp} - AQI: ${data.airQualityIndex}');  }
  //   );
}

  void onHourSelected(int index) {
    selectedIndex.value = index;
  selectedAirQualityData.value = hourlyData[index];
  }

  bool isSelected(int index) {
    return index == selectedIndex.value;
  }

  void onHoveredHourChanged(int? index) {
    hoveredHour.value = index;
  }
  
}


