import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:project/screens/no_disease.dart';
import 'dart:convert';

import 'package:project/screens/result_page.dart';

void main() => runApp(TestImage());

class TestImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        primaryColor: Color(0xFFFF9F68),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;
  bool isImageSelected = false;

  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        isImageSelected = true;
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        isImageSelected = true;
      } else {
        print('No image selected.');
      }
    });
  }

  Future sendImageForPrediction(File? imageFile) async {
    if (imageFile != null) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.8.100:5000/check'),
      );
      request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        var result = json.decode(utf8.decode(responseData));

        if(result['prediction']=='0'){

          Navigator.push(
            context,

            MaterialPageRoute(builder: (context) => NoSkinDiseaseFoundPage()),
          );
        }else{
          var request = http.MultipartRequest(
            'POST',
            Uri.parse('http://192.168.8.100:4000/predict'),
          );
          request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));

          var response = await request.send();
          var responseData = await response.stream.toBytes();
          var result = json.decode(utf8.decode(responseData));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(
                result: result['class'],
                description: result['description'],
                imageFile: _image!,
              ),
            ),
          );
        }

      } else {
        print('Failed to send image for prediction.');
      }
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skin Disease Detection'),
        backgroundColor: Color(0xFFFF9F68),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!),
            ElevatedButton(
              onPressed: getImageFromGallery,
              child: Text('Select Image from Gallery'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFFF9F68), //
                onPrimary: Colors.white, //
              ),
            ),
            ElevatedButton(
              onPressed: getImageFromCamera,
              child: Text('Capture Image from Camera'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFFF9F68),
                onPrimary: Colors.white,
              ),
            ),
            ElevatedButton(
              onPressed: isImageSelected
                  ? () => sendImageForPrediction(_image)
                  : null,
              child: Text('Detect Skin Disease'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFFF9F68),
                onPrimary: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
