import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_project/View/Profile/profile.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _key = GlobalKey<FormState>();
  Box<String> todoList = Hive.box<String>("todo");
  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

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
            child: Form(
              key: _key,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * 0.2,
                    child: TextFormField(
                      controller: subjectController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Empty';
                        }
                      },
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      decoration: const InputDecoration(
                        hintText: "Subject",
                        hintStyle: TextStyle(fontSize: 16),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.5,
                    child: TextFormField(
                      controller: bodyController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'The field is empty';
                        }
                      },
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      decoration: const InputDecoration(
                        hintText: "Enter your task",
                        hintStyle: TextStyle(fontSize: 16),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  IconButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        todoList.put(
                          subjectController.text.trim(),
                          bodyController.text.trim(),
                        );
                        subjectController.clear();
                        bodyController.clear();
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
          ),
          SizedBox(height: size.height * 0.05),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(thickness: 1),
          ),
          SizedBox(height: size.height * 0.009),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: todoList.listenable(),
              builder: (context, Box<String> todolist, child) {
                return ListView.separated(
                  itemCount: todolist.keys.toList().length,
                  separatorBuilder: (context, index) => Container(),
                  itemBuilder: (context, index) {
                    final key = todoList.keys.toList()[index];
                    final value = todoList.get(key);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      child: Card(
                        child: ListTile(
                          title: Text(
                            "$key",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                          subtitle: Text(
                            "$value",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              showAlertDialog(context, index: index);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future showAlertDialog(BuildContext context, {required int index}) async {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget logoutButton = TextButton(
      child: const Text(
        "Delete",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      onPressed: () async {
        todoList.deleteAt(index);
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      content: const Text("Are you sure to delete?"),
      actions: [
        cancelButton,
        logoutButton,
      ],
    );
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
