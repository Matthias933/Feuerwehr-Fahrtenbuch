// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AutoCompleteInput extends StatefulWidget {
  final List<String> names;
  final String labelText;
  final TextEditingController controller;
  const AutoCompleteInput({super.key, required this.names, required this.labelText, required this.controller});

  @override
  State<AutoCompleteInput> createState() => _AutoCompleteInputState();
}

class _AutoCompleteInputState extends State<AutoCompleteInput> {
  bool inputChanged = false;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue nameTextEditingValue) {
        if (nameTextEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return widget.names.where(
          (x) => x.toLowerCase().contains(nameTextEditingValue.text.toLowerCase()),
        );
      },
      onSelected: (String value) {
        debugPrint('You just selected $value');
        widget.controller.text = value;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
        textEditingController.text = widget.controller.text;

        textEditingController.addListener(() {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!widget.names.contains(textEditingController.text)) {
              if (!inputChanged) {
                setState(() {
                  inputChanged = true; 
                });
              }
            } else {
              if (inputChanged) {
                setState(() {
                  inputChanged = false;
                });
              }
            }
            widget.controller.text = textEditingController.text;
          });
        });

        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          onSubmitted: (String value) {
            onFieldSubmitted();
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: widget.labelText,
            errorText: inputChanged ? 'Bitte korrekten namen eingeben' : null,
          ),
        );
      },
    );
  }
}
