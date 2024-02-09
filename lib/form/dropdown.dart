import 'package:flutter/material.dart';

class DropdownQuestion extends StatefulWidget {
  final String field;
  final String questionText;
  final String initialSelectedItem;
  final List<String> options;

  const DropdownQuestion({
    super.key,
    required this.field,
    required this.questionText,
    required this.initialSelectedItem,
    required this.options,
  });

  @override
  State<DropdownQuestion> createState() => _DropdownQuestionState();
}

class _DropdownQuestionState extends State<DropdownQuestion> {
  late String _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialSelectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.questionText),
          const SizedBox(width: 10),
          DropdownButton<String>(
            value: _selectedItem,
            onChanged: (newValue) {
              setState(() {
                _selectedItem = newValue!;
              });
            },
            items: widget.options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
