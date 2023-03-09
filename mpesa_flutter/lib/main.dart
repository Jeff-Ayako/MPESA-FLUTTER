import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpesa_flutter/Views/homescreen.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';

void main() async {
  //initialisation of the consumer and secret key
  WidgetsFlutterBinding.ensureInitialized();
  // create a new project on Daraja then paste your own consumer keys and secret key
  MpesaFlutterPlugin.setConsumerKey('Fm2v0oUyaka8xx5g4346Hmh2b6tWCHcu');
  MpesaFlutterPlugin.setConsumerSecret('vVbvxAzuvMULEiTC');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MPESA Flutter ',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MainhomePage(),
    );
  }
}
