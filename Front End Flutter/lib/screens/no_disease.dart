import 'package:flutter/material.dart';

class NoSkinDiseaseFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('No Skin Disease Found'),
        backgroundColor: Color(0xFFFF9F68), // Adjust the color as needed
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.sentiment_satisfied, // You can choose an appropriate icon
              size: 100,
              color: Colors.green, // Adjust the color as needed
            ),
            Text(
              'No Skin Disease Found',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Text(
              '',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
