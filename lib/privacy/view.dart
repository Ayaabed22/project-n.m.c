import 'package:flutter/material.dart';
class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("الخصوصيه",style: TextStyle(fontSize: 24,fontWeight:FontWeight.w500,
        color: Theme.of(context).unselectedWidgetColor),),centerTitle:true,actions: [IconButton(onPressed: (){},
            icon: Image.asset('assets/icons/back.png',color: Theme.of(context).unselectedWidgetColor),iconSize: 24,)],
          backgroundColor: Colors.white,),

        body: Text('data'),
      ),
    );
  }
}