import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pnbproject/model/pegawai.dart';
import 'package:pnbproject/screens/mainscreen/mainscreen.dart';
import 'package:pnbproject/style.dart';
import 'package:pnbproject/widgets/customappdrawer.dart';

class Dashboard extends StatefulWidget {
  final bool? isFirstLoad;
  const Dashboard({Key? key, this.isFirstLoad}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Pegawai pegawai = Pegawai();
  String foto = '';
  double screenWidth = 0;
  double screenHeight = 0;

  String nama = '';
  String nip = '';
  String golongan = '';
  String jabatan = '';
  String tglMasuk = '';
  String status = '';

  @override
  void initState() {
    super.initState();
    getPhoto();
    Pegawai().getPegawaiData().then((value) {
      if(value != null) {
        setState(() {
          pegawai = value;
          nama = value.nama;
          nip = value.nip.toString();
          golongan = value.golongan!.golongan;
          jabatan = value.jabatan!.jabatan;
          tglMasuk = DateFormat('yyyy-MM-dd').format(value.tanggalMasuk!);
          status = value.status;
        });
        setMainName();
        saveDataPegawai();
      }
    });
  }

  void getPhoto() async {
    await Hive.openBox('userData');
    var box = Hive.box('userData');
    if(box.get('foto') != null) {
      setState(() {
        foto = box.get('foto');
      });
      print(foto);
    }
  }

  void saveDataPegawai() async {
    await Hive.openBox('pegawai');
    var box = Hive.box('pegawai');
    box.put('nip', int.parse(nip));
  }

  void setMainName() async {
    await Hive.openBox('userData');
    var box = Hive.box('userData');
    box.put('name', nama);

    if(widget.isFirstLoad!) {
      reload();
    }
  }

  void reload() {
    Navigator.pushReplacement(context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ),
    );
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "\nNama \n\nNIP \n\nGolongan \n\nJabatan \n\nTanggal Masuk \n\nStatus ",
                                ),
                                Text(
                                  "\n: $nama\n\n: $nip\n\n: $golongan\n\n: $jabatan\n\n: $tglMasuk\n\n: $status",
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
                                foto == '' ? Container(
                                  width: screenWidth,
                                  color: Colors.black,
                                  height: 135,
                                ) : Container(
                                  width: screenWidth,
                                  height: 135,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(
                                        File(foto),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20,),
                                GestureDetector(
                                  onTap: () async {
                                    final ImagePicker picker = ImagePicker();
                                    final XFile? image = await picker.pickImage(source: ImageSource.camera);

                                    setState(() {
                                      foto = image!.path;
                                    });

                                    Pegawai().updateFoto(foto).then((value) async {
                                      await Hive.openBox('userData');
                                      var box = Hive.box('userData');

                                      box.put('foto', foto).then((value) {
                                        Navigator.pushReplacement(context, MaterialPageRoute(
                                          builder: (context) => const MainScreen(isFirstLoad: true,),
                                        ));
                                      });
                                    });
                                  },
                                  child: Container(
                                    height: 35,
                                    width: screenWidth / 2.5,
                                    color: CustomStyle.secondaryColor,
                                    child: Center(
                                      child: Text(
                                        "Ubah Foto",
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
