import 'package:flutter/material.dart';
import 'package:pnbproject/screens/mainscreen/absensi.dart';
import 'package:pnbproject/screens/mainscreen/dashboard.dart';
import 'package:pnbproject/screens/mainscreen/datagaji.dart';
import 'package:pnbproject/screens/mainscreen/ubahpassword.dart';
import 'package:pnbproject/style.dart';

class MainScreen extends StatefulWidget {
  final int? screenState;
  const MainScreen({Key? key, this.screenState}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int screenState = 0;
  double screenWidth = 0;
  double screenHeight = 0;
  late Widget body;

  @override
  void initState() {
    super.initState();

    if(widget.screenState != null) {
      setState(() {
        screenState = widget.screenState!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    switch(screenState) {
      case 0:
        body = const Dashboard();
        break;
      case 1:
        body = const Absensi();
        break;
      case 2:
        body = const DataGaji();
        break;
      case 3:
        body = const UbahPassword();
        break;
    }

    return Scaffold(
      backgroundColor: CustomStyle.mainColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 110,
            ),
            child: body,
          ),
          Container(
            width: screenWidth,
            color: CustomStyle.accentColor,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Jurusan\nTeknik Elektro",
                      style: CustomStyle.white20.copyWith(
                        letterSpacing: -2,
                        fontSize: 24,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 12,),
                        Text(
                          "Nama",
                          style: CustomStyle.white20.copyWith(
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(width: 8,),
                        Container(
                          height: 35,
                          width: 35,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
