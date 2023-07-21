import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pnbproject/model/user.dart';
import 'package:pnbproject/screens/mainscreen/mainscreen.dart';
import 'package:pnbproject/style.dart';

class Login extends StatefulWidget {
  final bool isLoggedInUser;
  const Login({Key? key, required this.isLoggedInUser}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  double screenWidth = 0;
  double screenHeight = 0;
  bool buildUI = false;
  
  @override
  void initState() {
    super.initState();
    checkLogin();
  }
  
  void checkLogin() async {
    if(widget.isLoggedInUser) {
      Future.delayed(const Duration(milliseconds: 500), () {
        navigateNext();
      });
    } else {
      setState(() {
        buildUI = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: buildUI ? Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.ease,
            height: MediaQuery.of(context).viewInsets.bottom > 0 ? 30 : screenHeight / 5,
          ),
          Container(
            width: screenWidth,
            color: Colors.white38,
            margin: EdgeInsets.symmetric(
              horizontal: screenWidth / 12,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                Transform.translate(
                  offset: const Offset(0, -27.5),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 45,
                      ),
                    ),
                  ),
                ),
                formText(Icons.person, "Email", emailController),
                const SizedBox(height: 16,),
                formText(Icons.lock, "Password", passwordController),
                const SizedBox(height: 16,),
                GestureDetector(
                  onTap: () {
                    String email = emailController.text;
                    String password = passwordController.text.trim();

                    if(email.isEmpty) {
                      showNotification("Email masih kosong!");
                    } else if(password.isEmpty) {
                      showNotification("Password masih kosong!");
                    } else {
                      User().loginUser(email, password).then((value) async {
                        if(value != null) {
                          await Hive.openBox('userData');
                          var box = Hive.box('userData');
                          box.put('email', value.email);
                          box.put('password', value.password);
                          box.put('token', value.token);

                          navigateNext();
                        } else {
                          showNotification("Email atau password salah!");
                        }
                      });
                    }
                  },
                  child: Container(
                    height: 35,
                    width: screenWidth / 2.5,
                    color: CustomStyle.mainColor,
                    child: Center(
                      child: Text(
                        "Login",
                        style: CustomStyle.white20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
              ],
            ),
          ),
        ],
      ) : const SizedBox(),
    );
  }

  void navigateNext() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainScreen(isFirstLoad: true,),
      ),
    );
  }

  void showNotification(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
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
