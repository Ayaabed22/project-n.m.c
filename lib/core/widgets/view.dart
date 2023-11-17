// 'package:flutter/material.dart';
// class ButtonScreen extends StatefulWidget {
//   const ButtonScreen ({Key? key}) : super(key: key);
//
//   @override
//   State<ButtonScreen> createState() => _ButtonScreenState();
// }
// List<String>options=['yes','no'];
// class _ButtonScreenState extends State<ButtonScreen> {
//   String currentOptions=options[0];
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children:[(
//           title: Text('option1'),
//           leading: Radio(
//             value:options[0] ,
//             groupValue:currentOptions ,
//             onChanged: (value){
//               currentOptions=value.toString();
//             },
//           ),
//         ),],
//         // ),SizedBox(height: 10,),
//         // ListTile(
//         //   title: Text('option2'),
//         //   leading: Radio(
//         //     value:options[1] ,
//         //     groupValue:currentOptions ,
//         //     onChanged: (value){
//         //       currentOptions=value.toString();
//         //     },
//         //   ),
//         // ),
//
//     );
//   }
// }
