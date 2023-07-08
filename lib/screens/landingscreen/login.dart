import 'package:flutter/material.dart';
import 'package:pnbproject/screens/mainscreen/mainscreen.dart';
import 'package:pnbproject/style.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  double screenWidth = 0;
  double screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SizedBox(height: screenHeight / 5),
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
                formText(Icons.person, "Username", usernameController),
                const SizedBox(height: 16,),
                formText(Icons.lock, "Password", passwordController),
                const SizedBox(height: 16,),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                    );
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
