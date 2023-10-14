import 'package:flutter/material.dart';

class TextFieldCustomWidget extends StatelessWidget {
  const TextFieldCustomWidget({
    super.key,
    this.labelText,
    this.minLines = 1,
    required this.onChanged,
    this.helpText,
  });

  final String? labelText;
  final String? helpText;
  final int minLines;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: minLines,
      minLines: minLines,
      decoration: InputDecoration(
        labelText: labelText,
        helperText: helpText,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF7F7F7F), width: 1),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
