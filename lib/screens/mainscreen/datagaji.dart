import 'package:flutter/material.dart';
import 'package:pnbproject/model/gaji.dart';
import 'package:pnbproject/screens/printscreen.dart';
import 'package:pnbproject/style.dart';
import 'package:pnbproject/widgets/customappdrawer.dart';

class DataGaji extends StatefulWidget {
  const DataGaji({Key? key}) : super(key: key);

  @override
  State<DataGaji> createState() => _DataGajiState();
}

class _DataGajiState extends State<DataGaji> {
  double screenWidth = 0;
  double screenHeight = 0;

  Gaji gaji = Gaji();
  bool showData = false;

  String golongan = 'A';

  List<String> kolomTabel = [
    "No",
    "NIP",
    "Nama",
    "Gaji\nPokok",
    "Tunjangan\nTetap",
    "Tunjangan\nTransportasi",
    "Total",
    "Periode",
  ];

  List<String> rowGaji = [];

  @override
  void initState() {
    super.initState();
    getDataGaji();
  }

  void getDataGaji() async {
    Gaji().getDataGaji().then((value) async {
      setState(() {
        gaji = value!;
        rowGaji.add(gaji.nip.toString());
        rowGaji.add(gaji.pegawai!.nama);
        rowGaji.add(gaji.gajiPokok.toString());
        rowGaji.add(gaji.tunjanganTetap.toString());
        rowGaji.add(gaji.tunjanganTransportasi.toString());
        rowGaji.add(gaji.total.toString());
        rowGaji.add(gaji.periode);
        showData = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: const CustomAppDrawer(),
      drawerEdgeDragWidth: screenWidth / 4,
      backgroundColor: CustomStyle.mainColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
            Text(
              "Data Gaji",
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
                    height: 70,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: CustomStyle.secondaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Data Gaji",
                          style: CustomStyle.white20,
                        ),
    //               rowGaji.add(gaji.nip.toString());
    //               rowGaji.add(gaji.pegawai!.nama);
    //             rowGaji.add(gaji.gajiPokok.toString());
    //     rowGaji.add(gaji.tunjanganTetap.toString());
    // rowGaji.add(gaji.tunjanganTransportasi.toString());
    // rowGaji.add(gaji.total.toString());
    // rowGaji.add(gaji.periode.toString());
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => PrintScreen(
                                nama: rowGaji[1],
                                nip: rowGaji[0],
                                golongan: golongan,
                                gajiPokok: rowGaji[2],
                                tunjanganTetap: rowGaji[3],
                                tunjanganTransportasi: rowGaji[4],
                                total: rowGaji[5],
                              ),
                            ));
                          },
                          child: const Icon(
                            Icons.print,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 300, //Temporary
                    width: screenWidth,
                    color: Colors.white54,
                    padding: const EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        horizontalMargin: 6,
                        columnSpacing: 12,
                        border: TableBorder.all(color: Colors.black),
                        columns: [
                          for(int i = 0; i < kolomTabel.length; i++)...<DataColumn>[
                            DataColumn(
                              label: Text(
                                kolomTabel[i],
                                style: CustomStyle.black20.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ],
                        rows: [
                          showData ? DataRow(
                            cells: [
                              const DataCell(
                                Text("1"),
                              ),
                              for(int i = 0; i < rowGaji.length; i++)...<DataCell>[
                                DataCell(
                                  Text(rowGaji[i]),
                                ),
                              ],
                            ],
                          ) : DataRow(
                            cells: [
                              for(int i = 0; i < kolomTabel.length; i++)...<DataCell>[
                                const DataCell(
                                  Text("Loading..."),
                                ),
                              ],
                            ],
                          ),
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
    );
  }

  Widget tableCell(String text) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Text(
          text,
          style: CustomStyle.black20.copyWith(
            fontSize: 10,
          ),
        ),
      ),
    );
  }

}
