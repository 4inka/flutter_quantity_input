import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class QuantityInputAsInt extends StatefulWidget {
  final int value, step;
  final Function(int) onButtonPress;
  final Function(int)? onInput;
  final Color? buttonColor, iconColor;
  final String label;
  final bool readOnly, acceptsNegatives;

  QuantityInputAsInt({
    this.value = 1,
    this.step = 1,
    required this.onButtonPress,
    this.onInput,
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
                  if (widget.acceptsNegatives) widget.onButtonPress(-widget.step);
                  else widget.value == 1 ? widget.onButtonPress(0) : widget.onButtonPress(-widget.step);
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
                    inputFormatters: [
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        if (newValue.text.contains(RegExp(r'[a-zA-Z]')))
                          return oldValue;
                          
                        var formatter = NumberFormat("#,###,###,###,###,###,###,###,###,###,###,###,###,##0", "en_US");

                        String simpleValue = newValue.text
                          .replaceAll(',', '');

                        String formattedValue = formatter.format(int.parse(simpleValue));
                        
                        return TextEditingValue(
                          text: formattedValue,
                          selection: TextSelection.collapsed(
                            offset: formattedValue.length
                          )
                        );
                      })
                    ],
                    onChanged: (value) => widget.onInput != null ? widget.onInput!(int.parse(value.replaceAll(',', ''))) : null
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
                onTap: () => widget.onButtonPress(widget.step),
              )
            ],
          ),
        ],
      ),
    );
  }
}