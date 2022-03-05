import 'package:flutter/material.dart';
import 'package:hive_project/View/Profile/profile.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _key = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfilePage(),
                ),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: size.height * 0.03),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.7,
                  child: Form(
                    key: _key,
                    child: TextFormField(
                      controller: textController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'The field is empty';
                        }
                      },
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                IconButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      print(textController.text);
                    }
                  },
                  icon: const Icon(
                    Icons.done,
                    size: 30,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.08),
          const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10),
            child: Divider(thickness: 1),
          ),
          SizedBox(height: size.height * 0.1),
        ],
      ),
    );
  }
}
