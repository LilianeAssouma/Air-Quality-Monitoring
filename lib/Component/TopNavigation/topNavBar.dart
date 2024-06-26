

import 'package:flutter/material.dart';

class MenuUtils {
  static Widget buildMenu(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.27, 
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xffABCFF2),
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              title: const Text('Chart'),
              onTap: () {
                Navigator.pushNamed(context, '/chart');
              },
            ),
            ListTile(
              title: const Text('Health'),
              onTap: () {
                Navigator.pushNamed(context, '/health');
              },
            ),
           

          ],
        ),
      ),
    );
  }
}
