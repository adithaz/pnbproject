import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pnbproject/model/user.dart';
import 'package:pnbproject/screens/landingscreen/landingscreen.dart';
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
                  formText(Icons.lock, "Password Baru", passwordController),
                  const SizedBox(height: 16,),
                  formText(Icons.lock, "Ulangi Password", passwordConfirmController),
                  const SizedBox(height: 30,),
                  GestureDetector(
                    onTap: () async {
                      String password = passwordController.text.trim();
                      String passwordConfirm = passwordConfirmController.text.trim();

                      if(password.isEmpty) {
                        showNotification('Masukan password baru anda!');
                      } else if(passwordConfirm.isEmpty) {
                        showNotification('Konfirmasi password baru anda!');
                      } else {
                        await Hive.openBox('userData');
                        var box = Hive.box('userData');

                        User().resetPassword(password, passwordConfirm, box.get('token')).then((value) {
                          if(value) {
                            showNotification('Password berhasil dirubah!');
                            User().logoutUser(box.get('token')).then((value) {
                              if(value == true) {
                                Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context) => const LandingScreen(),
                                ));
                              }
                            });
                          } else {
                            showNotification("Password tidak valid.");
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
                          "Simpan",
                          style: CustomStyle.white20,
                        ),
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
