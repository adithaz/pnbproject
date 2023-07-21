import 'package:flutter/material.dart';
import 'package:pnbproject/style.dart';

class CustomRadioGroup extends StatefulWidget {
  final bool enabled;
  final String? initValue;
  final ValueChanged<String> value;
  const CustomRadioGroup({Key? key, required this.value, required this.enabled, this.initValue,}) : super(key: key);

  @override
  State<CustomRadioGroup> createState() => _CustomRadioGroupState();
}

class _CustomRadioGroupState extends State<CustomRadioGroup> {
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    if(widget.initValue != '') {
      setState(() {
        selectedValue = widget.initValue ?? '';
      });
    }

    return Column(
      children: [
        radio("Hadir"),
        const SizedBox(height: 4,),
        radio("Izin"),
        const SizedBox(height: 4,),
        radio("Sakit"),
      ],
    );
  }

  Widget radio(String text) {
    return GestureDetector(
      onTap: () {
        if(widget.enabled) {
          setState(() {
            selectedValue = text;
          });
          widget.value.call(selectedValue.toLowerCase());
        }
      },
      child: Row(
        children: [
          Container(
            height: 14,
            width: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selectedValue.toLowerCase() == text.toLowerCase() ? Colors.white : Colors.transparent,
              border: Border.all(
                color: Colors.white,
                width: 1.2,
              ),
            ),
          ),
          const SizedBox(width: 4,),
          Text(
            text,
            style: CustomStyle.white20.copyWith(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
