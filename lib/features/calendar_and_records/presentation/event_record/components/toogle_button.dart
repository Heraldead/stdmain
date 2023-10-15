import 'package:flutter/material.dart';
import 'package:std/features/calendar_and_records/models/record_model.dart';

class ToggleButtonWidget extends StatefulWidget {
  const ToggleButtonWidget({super.key, required this.onEvent});

  final ValueChanged<int> onEvent;

  @override
  State<ToggleButtonWidget> createState() => _ToggleButtonWidgetState();
}

class _ToggleButtonWidgetState extends State<ToggleButtonWidget> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ToggleButtons(
      borderRadius: BorderRadius.circular(100),
      selectedBorderColor: const Color(0xFF005BA1),
      borderColor: const Color(0xFFF03F54),
      selectedColor: Colors.white,
      fillColor: const Color(0xFF005BA1),
      isSelected: isSelected,
      constraints: BoxConstraints(
        minHeight: 40.0,
        minWidth: (width - 35) / 2,
      ),
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < isSelected.length; i++) {
            isSelected[i] = false;
            if (i == index) isSelected[i] = true;
          }
        });
        widget.onEvent(index);
      },
      children: RecordEnum.values
          .map((e) => Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text(e.title)))
          .toList(),
    );
  }
}
