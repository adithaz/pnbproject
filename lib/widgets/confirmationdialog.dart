import 'package:flutter/material.dart';
import 'package:pnbproject/style.dart';

class ConfirmationDialog extends StatefulWidget {
  const ConfirmationDialog({Key? key}) : super(key: key);

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  double screenHeight = 0;
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: screenWidth / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20,),
            Icon(
              Icons.check_circle,
              color: CustomStyle.secondaryColor,
              size: 80,
            ),
            const SizedBox(height: 20,),
            Text(
              "Terima Kasih Absen Disimpan",
              style: CustomStyle.black20.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
