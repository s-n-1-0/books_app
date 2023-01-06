import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      required this.onChanged,
      required this.hintText,
      required this.keyboardType})
      : super(key: key);
  final void Function(String) onChanged;
  final String hintText;
  final TextInputType keyboardType;
  @override
  State<CustomTextField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          //width: double.infinity,
          child: TextField(
        controller: _controller,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          isDense: true,
        ),
        onChanged: (_) {
          widget.onChanged(_controller.text);
        },
      )),
      (() {
        if (_controller.text != "") {
          return GestureDetector(
              onTap: () {
                _controller.clear();
                widget.onChanged(_controller.text);
              },
              child: const Icon(
                Icons.close,
                color: Colors.black45,
              ));
        }
        return const SizedBox();
      })(),
    ]);
  }

  void changeText(String newText) {
    _controller.text = newText;
    widget.onChanged(newText);
  }
}
