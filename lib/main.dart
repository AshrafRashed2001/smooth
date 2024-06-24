import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smooth/app/app.dart';
import 'package:smooth/core/SharedPref/shared_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedHelper.initshared();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
