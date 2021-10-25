import 'package:flutter/material.dart';

class QuantityInputAsInt extends StatefulWidget {
  final int value, step;
  final Function(int) onChanged;
  final Color? buttonColor, iconColor;
  final String label;
  final bool readOnly, acceptsNegatives;

  QuantityInputAsInt({
    this.value = 1,
    this.step = 1,
    required this.onChanged,
    this.buttonColor,
    this.iconColor,
    this.label = '',
    this.readOnly = false,
    this.acceptsNegatives = false
  });

  @override
  _QuantityInputAsIntState createState() => _QuantityInputAsIntState();
}

class _QuantityInputAsIntState extends State<QuantityInputAsInt> {
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
                    size: 25,
                    color: widget.iconColor != null ? widget.iconColor : Colors.white
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: widget.buttonColor != null ? widget.buttonColor : Theme.of(context).primaryColor,
                  ),
                  width: 38,
                  height: 38
                ),
                onTap: () {
                  if (widget.acceptsNegatives) widget.onChanged(-widget.step);
                  else widget.value == 1 ? widget.onChanged(0) : widget.onChanged(-widget.step);
                }
              ),
              Container(
                constraints: BoxConstraints(
                  maxHeight: 38,
                  maxWidth:70,
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
                    size: 25,
                    color: widget.iconColor != null ? widget.iconColor : Colors.white
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: widget.buttonColor != null ? widget.buttonColor : Theme.of(context).primaryColor,
                  ),
                  width: 38,
                  height: 38
                ),
                onTap: () => widget.onChanged(widget.step),
              )
            ],
          ),
        ],
      ),
    );
  }
}