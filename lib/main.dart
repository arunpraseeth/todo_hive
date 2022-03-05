import 'package:flutter/material.dart';
import 'package:hive_project/Controller/obscure_controller.dart';
import 'package:hive_project/View/Home/home_page.dart';
import 'package:hive_project/View/Login/enter_number.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? otp;
  @override
  void initState() {
    getOTP();
    super.initState();
  }

  getOTP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      otp = sharedPreferences.getString("otp");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) =>ObscureController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: otp == null ? EnterNumberPage() : HomePage(),
      ),
    );
  }
}
