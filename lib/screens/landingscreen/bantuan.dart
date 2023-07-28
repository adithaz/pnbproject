import 'package:flutter/material.dart';
import 'package:pnbproject/style.dart';
import 'package:url_launcher/url_launcher.dart';

class Bantuan extends StatelessWidget {
  const Bantuan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SizedBox(height: screenHeight / 8,),
          GestureDetector(
            onTap: () {
              _launchUrl(Uri.parse("https://wa.me/6281239083364"));
            },
            child: Container(
              width: screenWidth,
              color: Colors.white54,
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth / 12,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16,),
                  Text(
                    "API Whatsapp",
                    style: CustomStyle.black20,
                  ),
                  const SizedBox(height: 14,),
                  Image.asset(
                    'assets/images/whatsapplogo.png',
                    height: 80,
                  ),
                  const SizedBox(height: 30,),
                ],
              ),
            ),
          ),
          Padding(
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
        ],
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
