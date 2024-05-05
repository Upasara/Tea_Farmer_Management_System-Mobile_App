import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tefmasys_mobile/db/authentication.dart';
import 'package:tefmasys_mobile/ui/app_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final user = await Authentication().getLoggedUser();
  runApp(AppView(user?.email));
}



