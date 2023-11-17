import 'package:flutter/material.dart';

class CustomDialogWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        height:200,
        child:Column(
          children: [
            Container(
              child:Icon(Icons.add,size: 60,),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
