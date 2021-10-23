import 'package:flutter/material.dart';

class QuantityInputForInt extends StatefulWidget {
  final int value;
  final Function(int) onChanged;
  final Color? color;
  final String label;
  final bool readOnly;

  QuantityInputForInt({
    this.value = 1,
    required this.onChanged,
    this.color,
    this.label = '',
    this.readOnly = false
  });

  @override
  QuantityInputForIntState createState() => QuantityInputForIntState();
}

class QuantityInputForIntState extends State<QuantityInputForInt> {
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.value.toString();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.label.isNotEmpty,
            child: Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                widget.label,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 13,
                  fontWeight: FontWeight.w500
                )
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Container(
                  child: Icon(
                    Icons.remove,
                    size: 25
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: widget.color != null ? widget.color : Theme.of(context).primaryColor,
                  ),
                  width: 38,
                  height: 38
                ),
                onTap: () => widget.value == 1 ? widget.onChanged(0) : widget.onChanged(-1)
              ),
              Container(
                constraints: BoxConstraints(
                  maxHeight: 38,
                  maxWidth:70,
                  //minHeight: 50,
                  minWidth: 50
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: TextField(
                    controller: _controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      isDense: true
                    ),
                    readOnly: widget.readOnly,
                    keyboardType: TextInputType.number,
                  )
                )
              ),
              GestureDetector(
                child: Container(
                  child: Icon(
                    Icons.add,
                    size: 25
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: widget.color != null ? widget.color : Theme.of(context).primaryColor,
                  ),
                  width: 38,
                  height: 38
                ),
                onTap: () => widget.onChanged(1),
              )
            ],
          ),
        ],
      ),
    );
  }
}