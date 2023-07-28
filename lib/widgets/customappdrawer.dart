import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pnbproject/model/user.dart';
import 'package:pnbproject/screens/landingscreen/landingscreen.dart';
import 'package:pnbproject/screens/mainscreen/mainscreen.dart';
import 'package:pnbproject/style.dart';

class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Drawer(
      width: screenWidth / 1.5,
      backgroundColor: CustomStyle.secondaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16,),
          Text(
            "Penggajian",
            style: CustomStyle.white20.copyWith(
              fontSize: 30,
            )
          ),
          const SizedBox(height: 8,),
          Container(
            height: 1,
            color: Colors.white,
            child: Text(
              "Penggajian",
              style: TextStyle(
                color: CustomStyle.secondaryColor,
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(height: 20,),
          drawerTile(Icons.speed, "Dashboard", () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => const MainScreen(screenState: 0,),
            ));
          }),
          drawerTile(Icons.co_present, "Absensi", () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => const MainScreen(screenState: 1,),
            ));
          }),
          drawerTile(Icons.query_stats, "Data Gaji", () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => const MainScreen(screenState: 2,),
            ));
          }),
          drawerTile(Icons.lock, "Ubah Password", () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => const MainScreen(screenState: 3,),
            ));
          }),
          drawerTile(Icons.logout, "Keluar", () {
            getUserToken().then((token) {
              User().logoutUser(token).then((success) {
                if(success) {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => const LandingScreen(),
                  ));
                }
              });
            });
          }),
        ],
      ),
    );
  }

  Future<String> getUserToken() async {
    await Hive.openBox('userData');
    var box = Hive.box('userData');
    return box.get('token');
  }

  Widget drawerTile(IconData icon, String text, VoidCallback function) {
    return InkWell(
      onTap: function,
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(width: 12,),
            Text(
              text,
              style: CustomStyle.white20,
            ),
          ],
        ),
      ),
    );
  }
}

