import 'package:flutter/material.dart';
import 'package:gallery/utils/network_controller/dependency_injection.dart';
import 'package:gallery/views/gallery/view/gallery.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Gallery(),
    );
  }
}
