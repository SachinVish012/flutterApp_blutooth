import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:test_blutooth/view/first_screen/random_dog_image.dart';
import 'package:test_blutooth/view/main_screen.dart';
import 'package:test_blutooth/view/profile_screen/profile_view.dart';
import 'package:test_blutooth/view_model/randomgDogImg_provier.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:[
          ChangeNotifierProvider(create: (_)=>RandomDogIMGProvider()),
        ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: DashboardScreen(),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}

