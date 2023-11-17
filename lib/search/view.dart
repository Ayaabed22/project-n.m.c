import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class SearchScreenClass extends StatefulWidget {
   SearchScreenClass  ({Key? key}) : super(key: key);

  @override
  State<SearchScreenClass> createState() => _SearchScreenClassState();
}

class _SearchScreenClassState extends State<SearchScreenClass> {
  List<String> items = [];
  String? selectedValue='السويس';

  @override
  void initState() {
    super.initState();
    _loadJsonData();

  }

  Future<void> _loadJsonData() async {
    final jsonString = await rootBundle.loadString('assets/json/data.json');
    final jsonData = json.decode(jsonString);

    if (jsonData is List<String>) {
      setState(() {
        items = jsonData;
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Center(
        child:
        DropdownButton<String>(
          hint: Text('Select an option'),
          value: selectedValue,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
          },
        ),

      ),
    );
  }
}





