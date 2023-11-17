import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/core/widgets/btn.dart';
import 'package:n_m_c/home/cart/paymentMethod/cubit.dart';
import 'package:n_m_c/home/cart/paymentMethod/model.dart';
import 'package:n_m_c/home/cart/paymentMethod/steates.dart';
import '../cartdata/cubit.dart';
import '../cartdata/steates.dart';
import '../familycartscreen.dart';
import '../indivudalcartscreen.dart';
import '../personcartdetails/cubit.dart';
import '../personcartdetails/steats.dart';

class PaymentScreen extends StatefulWidget {
  AddDataModel? userData = AddDataModel();
  List<PersonModelData>? data;
  String? type;
  File? image;

  PaymentScreen({Key? key, this.userData, this.data, this.type, this.image})
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}


class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    BlocProvider.of<PaymentCubit>(context).getPaymentMethods();
    super.initState();
  }

  late modelDataSection? paymentModel;
  bool steate = false;
  List<int> Id = [2, 3, 4, 11, 12, 14];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          // BlocProvider(
          //   create: (context) => PaymentCubit()..getPaymentMethods(),
          // ),
          /*BlocProvider(
          create: (context) => CartDataCubit(),
        ),*/
          BlocProvider(
            create: (context) => CartCubit(),
          )
        ],
        child: Builder(builder: (context) {
          PaymentCubit cubit = BlocProvider.of(context);
          CartDataCubit cartDataCubit = BlocProvider.of(context);

          return Scaffold(
              body: BlocConsumer<PaymentCubit, PaymentMethodSteates>(
              bloc: cubit,
              listener: (context, steate)
          =>
          {
            if (steate is SuccessPaymentMethodSteates) {}
          },
          builder: (context, steate) {
          if (steate is LoadingPaymentMethodSteates) {
          return const Center(
          child: CircularProgressIndicator(),
          );
          } else {
          return SafeArea(
          child: SingleChildScrollView(
          child: Column(
          children: [
          Text(
          'حدد طريقة الدفع',
          style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color:
          Theme.of(context).unselectedWidgetColor),
          ),
          SizedBox(
          height: MediaQuery.of(context).size.height * .9,
          width: double.infinity,
          child: ListView.builder(
          itemBuilder: (context, int index) {
          return ListTile(
          title: Column(
          children: [
          Text(
          cubit.paymentModel?.data
              .payment[index].nameEn ??
          " ",
          style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400),
          ),
          const SizedBox(
          width: 5,
          ),
          Image.network(
          cubit.paymentModel?.data
              .payment[index].logo ??
          "",
          width: MediaQuery.of(context)
              .size
              .width *
          .8,
          height: MediaQuery.of(context)
              .size
              .height *
          .09,
          ),
          ],
          ),
          leading: Radio(
          value: Id[index],
          groupValue: cubit.selectdItem,
          onChanged: (value) {
          setState(() {
          cubit.selectdItem = value!;
          if(cubit.selectdItem==3){
          cubit.redirect='false';
          print(cubit.selectdItem);
          print(cubit.redirect);

          }
          else if(cubit.selectdItem==4){
          cubit.redirect='false';
          }
          else if(cubit.selectdItem==12){
          cubit.redirect='false';

          }
          else if(cubit.selectdItem==14){
          cubit.redirect='false';
          }
          else if (cubit.selectdItem==11){
          cubit.redirect='true';
          }
          else if (cubit.selectdItem==2){
            cubit.redirect='true';
          }

          });
          }));
          },
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          clipBehavior: Clip.antiAlias,
          padding: EdgeInsets.all(10),
          itemCount:
          cubit.paymentModel!.data.payment.length,
          ),
          ),
          SizedBox(
          width: MediaQuery.of(context).size.width * 2,
          ),
          BlocConsumer<CartDataCubit, SendDataCartSteates>(
          listener: (blocone,stateone) {},
          builder: (blocone,stateone){
          return BlocConsumer<CartCubit,CartStates>
          (listener:(context,statetwo){
          if (statetwo is SuccessCartStates){
          context.read<CartCubit>().getpaymentway(context);

          }},
          builder:(context,statetwo){
            if (stateone is LoadingSendDataCartSteates) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else {
              return Btn(
                  btnText: 'التالي',
                  onPress: () async {
                    await BlocProvider.of<CartDataCubit>(blocone).sendInformationCartData(
                      widget.userData!,
                      widget.type!,
                      cubit.selectdItem!,
                    );
                    BlocProvider.of<CartCubit>(context)
                        .sendData(
                      context,
                      widget.data ?? [],
                      widget.userData!,
                      cartDataCubit.cardKey ?? '',
                      widget.type!,
                      image: widget.image,
                    );


                  });
            }
          });

          },
          )
          // BlocConsumer<CartDataCubit, SendDataCartSteates>(
          // listener: (context, steate) => {
          // if (steate is SuccessCartStates){
          // context.read<CartCubit>().getpaymentway(context)}
          // },
          // builder: (context, steate) {
          // if (steate is LoadingSendDataCartSteates) {
          // return Center(
          // child: CircularProgressIndicator(),
          // );
          // } else {
          // return Btn(
          // btnText: 'التالي',
          // onPress: () async {
          // await cartDataCubit.sendInformationCartData(
          // widget.userData!,
          // widget.type!,
          // cubit.selectdItem!,
          // );
          // BlocProvider.of<CartCubit>(context)
          //     .sendData(
          // context,
          // widget.data ?? [],
          // widget.userData!,
          // cartDataCubit.cardKey ?? '',
          // widget.type!,
          // image: widget.image,
          // );
          //
          //
          // });
          // }
          // }),
          // SizedBox(
          // height: 30,
          // ),
          ],
          ),
          ),
          );
          }
        }));
  }

  )

  ,

  );
}}





