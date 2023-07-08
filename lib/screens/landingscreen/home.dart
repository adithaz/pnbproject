import 'package:flutter/material.dart';
import 'package:pnbproject/style.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 100),
          child: Row(
            children: [
              Text(
                "Politeknik Negeri Bali\nJurusan Teknik Elektro",
                style: CustomStyle.white20,
              ),
              Image.asset('assets/images/logopnb.png', height: 50,),
            ],
          ),
        ),
      ),
    );
  }
}
