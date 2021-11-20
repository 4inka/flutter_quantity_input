import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class QuantityInputAsDouble extends StatefulWidget {
  final double value, step;
  final Function(double) onButtonPress;
  final Function(double)? onInput;
  final Color? buttonColor, iconColor;
  final String label;
  final bool readOnly, acceptsNegatives;
  final InputDecoration? decoration;

  QuantityInputAsDouble({
    this.value = 1,
    this.step = 1,
    required this.onButtonPress,
    this.onInput,
    this.buttonColor,
    this.iconColor,
    this.label = '',
    this.readOnly = false,
    this.acceptsNegatives = false,
    this.decoration
  });

  @override
  _QuantityInputAsDoubleState createState() => _QuantityInputAsDoubleState();
}

class _QuantityInputAsDoubleState extends State<QuantityInputAsDouble> {
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
                    color: widget.buttonColor != null ? widget.buttonColor : Theme.of(context).primaryColor
                  ),
                  width: 38,
                  height: 38
                ),  
                onTap: () {
                  if (widget.acceptsNegatives) widget.onButtonPress(-widget.step);
                  else if ((widget.value - widget.step) > 0) widget.onButtonPress(-widget.step);
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
                    decoration: InputDecoration(//[0-9]+.[0-9] r'(^-?\d*\.?\d*)' [0-9.,]+ ([0-9]+(\.[0-9]+)?)
                      isDense: true
                    ),
                    readOnly: widget.readOnly,
                    inputFormatters: [
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        if (newValue.text.contains(RegExp(r'[a-zA-Z]')))
                          return oldValue;
                          
                        var formatter = NumberFormat("#,###,###,###,###,###,###,###,###,###,###,###,###,##0.0", "en_US");

                        String simpleValue = newValue.text
                          .replaceAll(',', '')
                          .replaceAll('.', '');

                        if (simpleValue.length == 1) simpleValue = simpleValue.padLeft(1, '0');

                        String fullPartOfDouble = simpleValue.substring(0, simpleValue.length - 1);
                        String decimalPartOfDouble = simpleValue.substring(simpleValue.length - 1);
                        String newFullValue = '$fullPartOfDouble.$decimalPartOfDouble';
                        String formattedValue = formatter.format(double.parse(newFullValue));
                        
                        return TextEditingValue(
                          text: formattedValue,
                          selection: TextSelection.collapsed(
                            offset: formattedValue.length
                          )
                        );
                      })
                    ],
                    onChanged: (value) => widget.onInput != null ? widget.onInput!(double.parse(value.replaceAll(',', ''))) : null
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
                    color: widget.buttonColor != null ? widget.buttonColor : Theme.of(context).primaryColor
                  ),
                  width: 38,
                  height: 38
                ),
                onTap: () => widget.onButtonPress(widget.step),
              )
            ],
          ),
        ],
      ),
    );
  }
}