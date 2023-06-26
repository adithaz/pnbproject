import 'package:flutter/material.dart';
import 'package:pnbproject/screens/mainscreen/mainscreen.dart';
import 'package:pnbproject/style.dart';
import 'package:pnbproject/widgets/customappdrawer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double screenWidth = 0;
  double screenHeight = 0;

  String nama = '';
  String nip = '';
  String golongan = '';
  String jabatan = '';
  String tglMasuk = '';
  String status = '';

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
              "Dashboard",
              style: CustomStyle.white20.copyWith(
                fontSize: 24,
              ),
            ),
            Text(
              "Selamat datang, anda login sebagai pegawai",
              style: CustomStyle.white20.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 40,),
            SizedBox(
              width: screenWidth,
              child: Column(
                children: [
                  Container(
                    height: 70,
                    padding: const EdgeInsets.only(left: 20),
                    color: CustomStyle.secondaryColor,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Data Pegawai",
                        style: CustomStyle.white20,
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth,
                    color: Colors.white54,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text(
                                  "\nNama \n\nNIP \n\nGolongan \n\nJabatan \n\nTanggal Masuk \n\nStatus ",
                                ),
                                Text(
                                  ": $nama\n\n: $nip\n\n: $golongan\n\n: $jabatan\n\n: $tglMasuk\n\n: $status",
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const SizedBox(height: 20,),
                                Container(
                                  width: screenWidth,
                                  color: Colors.black,
                                  height: 135,
                                ),
                                const SizedBox(height: 20,),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => const MainScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 35,
                                    width: screenWidth / 2.5,
                                    color: CustomStyle.secondaryColor,
                                    child: Center(
                                      child: Text(
                                        "Ubah Profil",
                                        style: CustomStyle.white20.copyWith(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
