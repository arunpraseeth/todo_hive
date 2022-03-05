import 'package:flutter/material.dart';
import 'package:hive_project/View/Login/enter_number.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onSelected: (value) {
              switch (value) {
                case 1:
                  showAlertDialog(context);
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: const [
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    Text(
                      " Logout",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 70,
                child: ClipOval(
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.asset(
                      "images/Wallpaper.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              const Text(
                "Arun Praseeth",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                "Flutter Developer",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    socialNetwork(
                      color: Colors.amber,
                    ),
                    socialNetwork(
                      color: Colors.blue,
                    ),
                    socialNetwork(
                      color: Colors.red,
                    ),
                    socialNetwork(
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: size.height,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    color: Colors.black,
                  ),
                  child: Column(
                    children: [
                      heading(
                        text: "Skill",
                        fontsize: 16,
                        top: 30,
                        left: 30,
                      ),
                      SizedBox(height: size.height * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            skills(
                              color: Colors.amber,
                            ),
                            skills(
                              color: Colors.blue,
                            ),
                            skills(
                              color: Colors.red,
                            ),
                            skills(
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      heading(
                        text: "Profession",
                        fontsize: 16,
                        top: 30,
                        left: 30,
                      ),
                      heading(
                        text: "Flutter Developer",
                        fontsize: 18,
                        top: 15,
                        left: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding heading({
    required String text,
    required double fontsize,
    required double top,
    required double left,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: top, left: left),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontsize,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget socialNetwork({
    required Color color,
  }) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 0.1,
            blurRadius: 2,
            offset: const Offset(2.5, 2.5),
          ),
        ],
      ),
    );
  }

  Widget skills({
    required Color color,
  }) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  Future showAlertDialog(BuildContext context) async {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget logoutButton = TextButton(
      child: const Text(
        "Logout",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      onPressed: () async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.remove("otp");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => EnterNumberPage(),
          ),
          (route) => false,
        );
      },
    );

    AlertDialog alert = AlertDialog(
      content: const Text("Are you sure to logout?"),
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
