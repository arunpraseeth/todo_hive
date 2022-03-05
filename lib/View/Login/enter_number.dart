// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:hive_project/Common/custom_navigator_button.dart';
import 'package:hive_project/Common/custom_textfield.dart';
import 'package:hive_project/View/Login/enter_otp.dart';

class EnterNumberPage extends StatelessWidget {
  EnterNumberPage({Key? key}) : super(key: key);

  final _key = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.2),
            Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: CustomTextField.customTextField(
                  focusnode: focusNode,
                  controller: numberController,
                  maxLength: 10,
                  textInputType: TextInputType.number,
                  textSpacing: 3,
                  hintText: 'Enter your number',
                  validator: (value) {
                    if (value!.length < 10) {
                      return 'Kindly enter a valid mobile number';
                    }
                  },
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
            ),
            SizedBox(height: size.height * 0.06),
            CustomNavigatorButton.customButton(
              context: context,
              size: size,
              boxName: "Send OTP",
              onTap: () {
                if (_key.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EnterOTPPage(
                        numberController: numberController,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
