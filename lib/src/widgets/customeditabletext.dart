import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomEditableText extends StatefulWidget {
  String data;
  String field;
  TextStyle style;
  CustomEditableText(
      {Key? key, required this.data, required this.field, required this.style})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomEditableText();
}

class _CustomEditableText extends State<CustomEditableText> {
  bool _isEditing = false;
  final TextEditingController _dataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return !_isEditing
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.data,
                style: widget.style,
              ),
              GestureDetector(
                  onTap: () {
                    _isEditing = true;
                    _dataController.text = widget.data;
                    setState(() {});
                  },
                  child: const Icon(Icons.border_color_outlined))
            ],
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    width: 10,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _dataController,
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      _isEditing = false;
                      _dataController.text = widget.data;
                      setState(() {});
                    },
                    child:
                        const Icon(Icons.cancel_outlined, color: Colors.red)),
                const SizedBox(width: 10),
                GestureDetector(
                    onTap: () {
                      _isEditing = false;
                      widget.data = _dataController.text.trim();
                      // saveData();
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.check,
                      color: Colors.green,
                    )),
              ],
            ),
          );
  }
}
