import 'package:flutter/material.dart';
//import 'dart:async';
import 'dart:ui';
import 'package:airquality_flutter_application/Screen/home_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Stack(
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
            alignment: const AlignmentDirectional(-3, -0.3),
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
              decoration: const BoxDecoration(color: Colors.transparent),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Spacer(),
                Image.asset("assets/7.png"),
                const Spacer(flex: 2),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: "AirQuality ",
                            style: TextStyle(color: Colors.white)),
                        TextSpan(
                          text: "News \n& Feeds",
                          style: TextStyle(
                            color: Color(0xffFED058),
                          ),
                        ),
                      ],
                    ),
                    style: TextStyle(
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
              "Stay Informed, Breathe Better, Live Healthier. Accessible Air Solutions for a Cleaner, Healthier Environment",
              style: TextStyle(
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFED058),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Get started",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}











//   Expanded(
//                   flex: 1,
//                   child: Center(
//                     child: PageTransitionSwitcher(
//                       duration: const Duration(seconds: 1),
//                       transitionBuilder: (child, animation, secondaryAnimation) {
//                         return SharedAxisTransition(
//                           child: child,
//                           animation: animation,
//                           secondaryAnimation: secondaryAnimation,
//                           transitionType: SharedAxisTransitionType.horizontal,
//                         );
//                       },
//                       child: Text(
//                         _messages[_currentIndex],
//                         key: ValueKey<int>(_currentIndex),
//                         style: const TextStyle(fontSize: 20.0, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
// expand_more
