// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hive_project/Common/custom_navigator_button.dart';
import 'package:hive_project/Common/custom_textfield.dart';
import 'package:hive_project/Controller/obscure_controller.dart';
import 'package:hive_project/View/Home/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnterOTPPage extends StatelessWidget {
  final TextEditingController numberController;
  EnterOTPPage({Key? key, required this.numberController}) : super(key: key);

  final _key = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool _visibility = Provider.of<ObscureController>(context).visibityData;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: CustomTextField.customTextField(
                readOnly: true,
                textSpacing: 3,
                controller: numberController,
                validator: (value) {},
                prefix: const Padding(
                  padding: EdgeInsets.only(
                    top: 11.5,
                    left: 15,
                  ),
                  child: Text(
                    '+91 ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: CustomTextField.customTextField(
                  controller: otpController,
                  maxLength: 4,
                  obscureText: _visibility,
                  textInputType: TextInputType.number,
                  textSpacing: 3,
                  hintText: 'Enter OTP',
                  validator: (value) {
                    if (value!.length < 4) {
                      return 'Kindly enter a valid OTP';
                    }
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      Provider.of<ObscureController>(context, listen: false)
                          .visibity(obscure: !_visibility);
                    },
                    icon: Icon(
                        _visibility ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.06),
            CustomNavigatorButton.customButton(
              context: context,
              size: size,
              boxName: "Verify",
              onTap: () async {
                if (_key.currentState!.validate()) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomePage(),
                    ),
                    (route) => false,
                  );
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  await sharedPreferences.setString(
                      "otp", otpController.text.trim());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
