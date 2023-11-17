import 'package:flutter/material.dart';
class Screen extends StatelessWidget {
  const Screen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // child: ListView.separated(
    //   scrollDirection: Axis.horizontal,
    //   itemBuilder: (context, index) => Expanded(
    //     child: Container(
    //       child:
    //       Image.network(cubit.listOfSlider[index].imageUrl),
    //       clipBehavior: Clip.antiAlias,
    //       width: double.infinity,
    //       height: 104,
    //       decoration: BoxDecoration(
    //         color: Colors.black,
    //         //color: Colors.grey.withOpacity(0.77),
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //     ),
    //   ),
    //   itemCount: cubit.listOfSlider.length,
    //   separatorBuilder: (context, index) => SizedBox(
    //     width: 10,
    //   ),
    // ),

    return Container(
      width: 300,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index)=>Stack(
        children: [
          Container(
              clipBehavior: Clip.antiAlias,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset('assets/images/homepicture.png')),
          Positioned(
            bottom: 0,
            child: Container(
              width: 50,
              child: Text('المستشفيات'),
            ),
          )
          ,
        ],
      ), separatorBuilder: (context,index)=>SizedBox(width: 10,), itemCount: 5),
    );
  }
}
