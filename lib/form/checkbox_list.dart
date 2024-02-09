import 'package:flutter/material.dart';

class CheckboxQuestion extends StatefulWidget {
  final String field;
  final String questionText;
  final List<String> options;

  const CheckboxQuestion({
    super.key,
    required this.field,
    required this.questionText,
    required this.options,
  });

  @override
  State<CheckboxQuestion> createState() => _CheckboxQuestionState();
}

class _CheckboxQuestionState extends State<CheckboxQuestion> {
  late Map<String, bool> _checkedOptions;

  @override
  void initState() {
    super.initState();
    _checkedOptions = { for (var option in widget.options) option : false };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.questionText),
        ),
        ...widget.options.map((option) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: _checkedOptions[option],
                onChanged: (value) {
                  setState(() {
                    _checkedOptions[option] = value!;
                  });
                },
              ),
              Text(option),
            ],
          );
        }).toList(),
      ],
    );
  }
}
