import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pnbproject/screens/landingscreen/bantuan.dart';
import 'package:pnbproject/screens/landingscreen/home.dart';
import 'package:pnbproject/screens/landingscreen/login.dart';
import 'package:pnbproject/style.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  double screenWidth = 0;
  double screenHeight = 0;

  int screenState = 0;

  late Widget body;

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    await Hive.openBox('userData');
    var box = Hive.box('userData');

    if(box.get('token') != null) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    switch(screenState) {
      case 0:
        body = const Home();
        break;
      case 1:
        body = const Bantuan();
        break;
      case 2:
        body = const Login();
        break;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.fitHeight,
          )
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 120),
                child: body,
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 45,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              CustomStyle.accentColor.withOpacity(0),
                              CustomStyle.accentColor,
                            ],
                          ),
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Politeknik Negeri Bali",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset('assets/images/logopnb.png', height: 70,),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Penggajian",
                          style: CustomStyle.white20,
                        ),
                        Row(
                          children: [
                            navigation(0, "Home"),
                            divider(),
                            navigation(1, "Bantuan"),
                            divider(),
                            navigation(2, "Login"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return Container(
      height: 12,
      width: 1,
      margin: const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      color: Colors.white54,
    );
  }

  Widget navigation(int index, String text) {
    return GestureDetector(
      onTap: () {
        Feedback.forTap(context);
        setState(() {
          screenState = index;
        });
      },
      child: Text(
        text,
        style: CustomStyle.white20.copyWith(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget formText(IconData icon, String hint, TextEditingController controller) {
    return Container(
      width: screenWidth,
      color: Colors.white,
      child: TextFormField(
        controller: controller,
        obscureText: hint.toLowerCase() == "password" ? true : false,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(icon),
          prefixIconColor: Colors.black,
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 20,
          ),
        ),
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
