import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pnbproject/screens/mainscreen/absensi.dart';
import 'package:pnbproject/screens/mainscreen/dashboard.dart';
import 'package:pnbproject/screens/mainscreen/datagaji.dart';
import 'package:pnbproject/screens/mainscreen/ubahpassword.dart';
import 'package:pnbproject/style.dart';

class MainScreen extends StatefulWidget {
  final int? screenState;
  final bool? isFirstLoad;
  const MainScreen({Key? key, this.screenState, this.isFirstLoad}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int screenState = 0;
  double screenWidth = 0;
  double screenHeight = 0;
  String name = 'Nama';
  String foto = '';
  List<String> namaBali = ['putu', 'wayan', 'made', 'kadek', 'nyoman', 'komang', 'ketut', 'nengah', 'cokorda'];
  late Widget body;

  @override
  void initState() {
    super.initState();

    if(widget.screenState != null) {
      setState(() {
        screenState = widget.screenState!;
      });
    }

    getMainNameAndPhoto();
  }

  void getMainNameAndPhoto() async {
    await Hive.openBox('userData');
    var box = Hive.box('userData');
    List<String> temp = box.get('name').split(' ');
    if(temp[0].toLowerCase() == 'i' || temp[0].toLowerCase() == 'ni') {
      temp.removeAt(0);
    }
    for(int i = 0; i < namaBali.length; i++) {
      if(temp.contains(namaBali[i])) {
        temp.removeAt(0);
      }
    }
    if(box.get('foto') == null) {
      setState(() {
        name = temp[0];
      });
    } else {
      setState(() {
        foto = box.get('foto');
        name = temp[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    switch(screenState) {
      case 0:
        body = Dashboard(isFirstLoad: widget.isFirstLoad ?? false,);
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
                          name,
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
                          child: foto == '' ? const Center(
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 30,
                            ),
                          ) : ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: Image.file(File(foto)),
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
