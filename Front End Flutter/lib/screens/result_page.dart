import 'package:flutter/material.dart';
import 'dart:io';

class ResultPage extends StatelessWidget {
  final String result;
  final File imageFile;
  final String description;

  ResultPage({required this.result, required this.imageFile, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        backgroundColor: Color(0xFFFF9F68),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0), //
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 250, //
                height: 220, //
                decoration: BoxDecoration(

                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(imageFile),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Detection Result:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Text(
                result,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'Description:',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0), // Add some spacing
              Text(
                description,
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center, // Center-align the description text
              ),
            ],
          ),
        ),
      ),
    );
  }
}
