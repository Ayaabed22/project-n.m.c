import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadFile extends StatefulWidget {
  File? myFile;
   UploadFile({super.key, this.myFile});

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [InkWell(onTap: () async {
        XFile? xfile = await ImagePicker().pickImage(
            source: ImageSource.gallery);
        if (xfile != null) {
          setState(() {
           widget.myFile = File(xfile!.path);
          });
        }
      },child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text('Choose From Camera',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
      ),
      ),
        SizedBox(height: 4,),
        InkWell(onTap: () async {
          XFile? xfile = await ImagePicker().pickImage(source: ImageSource.camera);
          if (xfile != null) {
            setState(() {
             widget.myFile = File(xfile!.path);
            });
          }
        }, child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text('Choose From Camera',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),),
        ),),
      ],

    );
  }

}