import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pard_app/firebase_options.dart';
import 'package:pard_app/my_app.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
