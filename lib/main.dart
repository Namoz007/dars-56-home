import 'package:dars_56_home/Utils/app_utils.dart';
import 'package:dars_56_home/cubits/cart_cubit.dart';
import 'package:dars_56_home/cubits/order_cubit.dart';
import 'package:dars_56_home/cubits/product_cubit.dart';
import 'package:dars_56_home/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context){
            return ProductCubit();
          },
        ),
        BlocProvider(
          create: (context){
            return CartCubit();
          },
        ),
        BlocProvider(
          create: (context){
            return OrderCubit();
          },
        )
      ],
      child:  MaterialApp(
        theme: AppUtils.theme,
        debugShowCheckedModeBanner: false,
        home: HomeScreen()
      ),
    );
  }
}
