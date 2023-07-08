import 'package:flutter/material.dart';
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

  List<String> kolomTabel = [
    "No",
    "NIP",
    "Nama",
    "Gaji Pokok",
    "Tunjangan\nTetap",
    "Total",
    "Periode",
  ];

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
                        const RotatedBox(
                          quarterTurns: 1,
                          child: Icon(
                            Icons.compare_arrows,
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
                        columnSpacing: 14,
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
                        rows: const [],
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
