import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class CameraTest extends StatefulWidget {
  const CameraTest({Key? key}) : super(key: key);

  @override
  State<CameraTest> createState() => _CameraTestState();
}

class _CameraTestState extends State<CameraTest> {

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    return  Scaffold(
      body: GestureDetector(
        onTap: (){
          picker.pickImage(source: ImageSource.camera);
        },
        child: Container(
          width: 200,
          height: 200,
          color: Colors.red,
        ),
      ),
    );
  }
}
