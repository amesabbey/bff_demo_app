import 'package:flutter/material.dart';

class RadioButtonQuestion extends StatefulWidget {
  final String field;
  final String questionText;
  final List<String> options;

  const RadioButtonQuestion({
    super.key,
    required this.field,
    required this.questionText,
    required this.options,
  });

  @override
  State<RadioButtonQuestion> createState() => _RadioButtonQuestionState();
}

class _RadioButtonQuestionState extends State<RadioButtonQuestion> {
  String _selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return getRadioButtonQuestion(widget.questionText, widget.options);
  }

  Padding getRadioButtonQuestion(
      String questionText, List<String> questionOptions) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(questionText),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...[
                for (var option in questionOptions) ...[
                  Radio<String>(
                    value: option,
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedValue = value;
                        });
                      }
                    },
                  ),
                  Text(option),
                ]
              ],
            ],
          ),
        ],
      ),
    );
  }
}
