import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n_m_c/home/cart/cartdata/steates.dart';
import 'package:n_m_c/login/view.dart';

import '../../../core/logic/helpermethods.dart';
import 'cubit.dart';

class SendCartScreen extends StatelessWidget {
  const SendCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CartDataCubit(),
        child: Builder(builder: (context) {
          CartDataCubit cubit = BlocProvider.of(context);
          return Scaffold(
            body: BlocConsumer(
              bloc: cubit,
              listener: (context, steate) {
                if (steate is SuccessSendDataCartSteates) {}
              },
              builder: (context, steate) {
                if (steate is LoadingSendDataCartSteates) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Center(
                      child: GestureDetector(
                          onTap: () {
                           //  cubit.sendInformationCartData();
                          },
                          child: Text('test')));
                }
              },
            ),
          );
        }));
  }
}
