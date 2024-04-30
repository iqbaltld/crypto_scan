import 'package:crypto_scan/router/app_router.dart';
import 'package:crypto_scan/screens/home/home.dart';
import 'package:crypto_scan/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: MaterialApp(
        title: 'Crypto Scan',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: AppConstants.backgroundColor,
            brightness: Brightness.dark),
        onGenerateRoute: _appRouter.onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
