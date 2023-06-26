import 'package:flutter/material.dart';
import 'package:pnbproject/style.dart';
import 'package:pnbproject/widgets/confirmationdialog.dart';
import 'package:pnbproject/widgets/customappdrawer.dart';
import 'package:pnbproject/widgets/customradiogroup.dart';

class Absensi extends StatefulWidget {
  const Absensi({Key? key}) : super(key: key);

  @override
  State<Absensi> createState() => _AbsensiState();
}

class _AbsensiState extends State<Absensi> {
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
              "Absensi Pegawai",
              style: CustomStyle.white20.copyWith(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 40,),
            SizedBox(
              width: screenWidth,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 6,
                      right: 6,
                      top: 6,
                    ),
                    width: screenWidth,
                    color: Colors.white54,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: absenTile("Senin"),
                        ),
                        const SizedBox(width: 4,),
                        Expanded(
                          flex: 1,
                          child: absenTile("Selasa"),
                        ),
                        const SizedBox(width: 4,),
                        Expanded(
                          flex: 1,
                          child: absenTile("Rabu"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    width: screenWidth,
                    color: Colors.white54,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: absenTile("Kamis"),
                        ),
                        const SizedBox(width: 4,),
                        Expanded(
                          flex: 1,
                          child: absenTile("Jumat"),
                        ),
                        const SizedBox(width: 4,),
                        const Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                      ],
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

  Widget absenTile(String day) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: CustomStyle.tertiaryColor,
      child: Column(
        children: [
          Text(
            day,
            style: CustomStyle.white20,
          ),
          Container(
            height: 1,
            color: Colors.white,
            margin: const EdgeInsets.only(
              bottom: 6,
            ),
            child: Opacity(
              opacity: 0,
              child: Text(
                day,
                style: CustomStyle.white20,
              ),
            ),
          ),
          Text(
            "Jam masuk 7.00\nJam keluar 15:00",
            style: CustomStyle.white20.copyWith(
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12,),
          const CustomRadioGroup(),
          const SizedBox(height: 12,),
          GestureDetector(
            onTap: () {
              Feedback.forTap(context);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const ConfirmationDialog();
                },
              );
            },
            child: Container(
              height: 30,
              width: screenWidth / 2.5,
              color: CustomStyle.accentColor,
              child: Center(
                child: Text(
                  "Absen Pegawai",
                  style: CustomStyle.white20.copyWith(
                    fontSize: 14,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
