import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stockaxis_task/presentation/screens/pricing_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: PricingScreen(),
    );
  }
}




