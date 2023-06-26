import 'package:flutter/material.dart';
import 'package:pnbproject/style.dart';
import 'package:pnbproject/widgets/customappdrawer.dart';

class UbahPassword extends StatefulWidget {
  const UbahPassword({Key? key}) : super(key: key);

  @override
  State<UbahPassword> createState() => _UbahPasswordState();
}

class _UbahPasswordState extends State<UbahPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  double screenWidth = 0;
  double screenHeight = 0;

  String absensi = '';

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: const CustomAppDrawer(),
      drawerEdgeDragWidth: screenWidth,
      backgroundColor: CustomStyle.mainColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
            Text(
              "Form Ganti Password",
              style: CustomStyle.white20.copyWith(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 40,),
            Container(
              width: screenWidth,
              color: Colors.white54,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              child: Column(
                children: [
                  formText(Icons.lock, "Password baru", passwordController),
                  const SizedBox(height: 16,),
                  formText(Icons.lock, "Ulangi password", passwordConfirmController),
                  const SizedBox(height: 30,),
                  Container(
                    height: 35,
                    width: screenWidth / 2.5,
                    color: CustomStyle.mainColor,
                    child: Center(
                      child: Text(
                        "Simpan",
                        style: CustomStyle.white20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
        obscureText: hint.toLowerCase().contains('password') ? true : false,
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
