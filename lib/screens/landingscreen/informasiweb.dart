import 'package:flutter/material.dart';
import 'package:pnbproject/style.dart';

class InformasiWeb extends StatelessWidget {
  const InformasiWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const SizedBox(height: 60,),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: infoTile('assets/images/informasi-website1.png', "Tentang Website", () {
                    print('sd');
                  }),
                ),
                const SizedBox(width: 16,),
                Expanded(
                  flex: 1,
                  child: infoTile('assets/images/informasi-website2.png', "Halaman Admin", () {
                    print('sd');
                  }),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: infoTile('assets/images/informasi-website3.png', "Fitur Lainnya", () {
                    print('sd');
                  }),
                ),
                const SizedBox(width: 16,),
                Expanded(
                  flex: 1,
                  child: infoTile('assets/images/informasi-website4.png', "Halaman Karyawan", () {
                    print('sd');
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoTile(String asset, String text, VoidCallback onTap) {
    return Container(
      height: 230,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Image.asset(
              asset,
              height: 230 / 2,
            ),
          ),
          Text(
            text,
            style: CustomStyle.black20.copyWith(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12,),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 35,
              color: CustomStyle.secondaryColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Read More",
                    style: CustomStyle.white20.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
