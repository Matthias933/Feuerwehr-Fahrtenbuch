import 'package:flutter/material.dart';

class AutoCompleteInput extends StatefulWidget {
  final List<String> names;
  final String labelText;
  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;

  const AutoCompleteInput({
    super.key,
    required this.names,
    required this.labelText,
    required this.controller,
    this.onSubmitted,
  });

  @override
  State<AutoCompleteInput> createState() => _AutoCompleteInputState();
}

class _AutoCompleteInputState extends State<AutoCompleteInput> {
  bool inputChanged = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Autocomplete<String>(
          optionsBuilder: (TextEditingValue nameTextEditingValue) {
            if (nameTextEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return widget.names.where(
              (x) => x.toLowerCase().contains(nameTextEditingValue.text.toLowerCase()),
            );
          },
          onSelected: (String value) {
            debugPrint('You just selected $value');
            widget.controller.text = value;
            widget.onSubmitted?.call(value);
          },
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
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
                widget.onSubmitted?.call(value);
                onFieldSubmitted();
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: widget.labelText,
                errorText: inputChanged ? 'Bitte korrekten Namen eingeben' : null,
              ),
            );
          },
          optionsViewBuilder: (
            BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options,
          ) {
            return Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: constraints.maxWidth,
                child: Material(
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: options.map((e) {
                      return ListTile(
                        title: Text(e),
                        onTap: () {
                          onSelected(e);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
