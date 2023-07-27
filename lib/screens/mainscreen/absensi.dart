import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pnbproject/model/absen.dart';
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
  String token = '';
  int nip = 0;
  int now = DateTime.now().weekday;
  bool enabled = true;

  List<String> weekDay = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];

  @override
  void initState() {
    super.initState();
    getNipAndToken();
    checkAbsen();
  }

  void checkAbsen() async {
    await Hive.openBox('absen');
    var box = Hive.box('absen');

    int hari = box.get('hari');
    bool isAbsen = box.get('isAbsen');
    String hadir = box.get('hadir');

    if(hari == now) {
      if(isAbsen) {
        setState(() {
          enabled = false;
          absensi = hadir;
        });
      }
    }
  }

  void lockAbsen(String hadir) async {
    await Hive.openBox('absen');
    var box = Hive.box('absen');

    box.put('hari', now);
    box.put('isAbsen', true);
    box.put('hadir', hadir);
  }

  void getNipAndToken() async {
    await Hive.openBox('pegawai');
    await Hive.openBox('userData');
    var box = Hive.box('pegawai');
    var box2 = Hive.box('userData');
    setState(() {
      nip = box.get('nip');
      token = box2.get('token');
    });
  }

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
                          child: absenTile("Senin", 1),
                        ),
                        const SizedBox(width: 4,),
                        Expanded(
                          flex: 1,
                          child: absenTile("Selasa", 2),
                        ),
                        const SizedBox(width: 4,),
                        Expanded(
                          flex: 1,
                          child: absenTile("Rabu", 3),
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
                          child: absenTile("Kamis", 4),
                        ),
                        const SizedBox(width: 4,),
                        Expanded(
                          flex: 1,
                          child: absenTile("Jumat", 5),
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

  Widget absenTile(String day, int index) {
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
          index == now ? CustomRadioGroup(
            enabled: weekDay[now] == day ? (enabled ? true : false) : false,
            initValue: !enabled ? absensi : '',
            value: (absen) {
              setState(() {
                absensi = absen;
              });
            },
          ) : CustomRadioGroup(
            enabled: weekDay[now] == day ? (enabled ? true : false) : false,
            value: (absen) {
              setState(() {
                absensi = absen;
              });
            },
          ),
          const SizedBox(height: 12,),
          GestureDetector(
            onTap: () {
              if(weekDay[now] == day && enabled) {
                Feedback.forTap(context);
                Absen().kirimAbsen(nip, absensi, token).then((value) {
                  if(value == true) {
                    lockAbsen(absensi);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const ConfirmationDialog();
                      },
                    ).then((value) {
                      setState(() {
                        enabled = false;
                      });
                    });
                  }
                });
              }
            },
            child: Container(
              height: 30,
              width: screenWidth / 2.5,
              color: weekDay[now] == day ? (enabled ? CustomStyle.accentColor : Colors.grey) : Colors.grey,
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
