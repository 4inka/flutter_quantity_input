library quantity_input;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:quantity_input/widgets/icon-button.widget.dart';

export 'src/quantity_input_as_int.dart';
export 'src/quantity_input_as_double.dart';

class QuantityInput extends StatefulWidget {
  /// Has to be an int or double depending on QuantityInputType variable
  final dynamic value;
  final dynamic step;
  final int decimalDigits;
  /// Set min value to be displayed in input. If not set, it will be set to 1
  final dynamic minValue;
  final dynamic maxValue;
  /// ```dart
  /// min(5, 3) == 3
  /// ```
  final Function(dynamic) onChanged;
  final Color? buttonColor, iconColor;
  final String label;
  final bool readOnly;
  /// Default to false
  /// 
  /// Setting property to true enables the option to display negative values
  final bool acceptsNegatives;
  final QuantityInputType? type;
  final bool returnFormattedValue;

  /// Test widget 1
  QuantityInput({
    this.value = 1,
    this.step = 1,
    this.decimalDigits = 0,
    required this.onChanged,
    this.buttonColor,
    this.iconColor,
    this.label = '',
    this.readOnly = false,
    this.acceptsNegatives = false,
    this.minValue = 1,
    this.maxValue = 1000,
    this.type = QuantityInputType.forInt,
    this.returnFormattedValue = false
  });

  @override
  _QuantityInputState createState() => _QuantityInputState();
}

class _QuantityInputState extends State<QuantityInput> {
  late TextEditingController _controller = new TextEditingController();

  String valueFormatter(dynamic value) {
    String extraZeros = '';

    if(widget.decimalDigits > 0 && widget.type == QuantityInputType.forDouble) {
      extraZeros = '.';
      extraZeros.padRight(widget.decimalDigits, '0');
    }

    NumberFormat formatter = NumberFormat('#,###,###,###,###,###,###,###,###,##0$extraZeros', 'en_US');
    
    return formatter.format(value);
  }

  @override
  void initState() {
    super.initState();
    _controller.text = valueFormatter(widget.value);
  }

  @override
  Widget build(BuildContext context) {
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
              IconButtonWidget(
                icon: Icons.remove,
                iconColor: widget.iconColor,
                buttonColor: widget.buttonColor,
                onTap: () {
                  dynamic currentValue = 0;

                  if (widget.acceptsNegatives || widget.value != 1)
                    currentValue = widget.value - widget.step;
                  else
                    currentValue = widget.value;

                  String formattedValue = valueFormatter(currentValue);
                  _controller
                    ..value = TextEditingValue(
                      text: formattedValue,
                      selection: TextSelection.collapsed(
                        offset: formattedValue.length
                      )
                    );
                  widget.onChanged(currentValue);
                }
              ),
              Container(
                constraints: BoxConstraints(
                  maxHeight: 38,
                  maxWidth:150,
                  minWidth: 50
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: TextFormField(
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

                        if (newValue.text.isEmpty)
                          return TextEditingValue(
                            text: '0',
                            selection: TextSelection.collapsed(
                              offset: 1
                            )
                          );

                        String simpleValue = newValue.text.replaceAll(',', '');
                        String formattedValue = valueFormatter(int.parse(simpleValue));

                        return TextEditingValue(
                          text: formattedValue,
                          selection: TextSelection.collapsed(
                            offset: formattedValue.length
                          )
                        );
                      })
                    ],
                    onChanged: (value) => widget.onChanged(int.parse(value.replaceAll(',', '')))
                  )
                )
              ),
              IconButtonWidget(
                icon: Icons.add,
                iconColor: widget.iconColor,
                buttonColor: widget.buttonColor,
                onTap: () {
                  dynamic currentValue = widget.value + widget.step;
                  String formattedValue = valueFormatter(currentValue);
                  _controller
                    ..value = TextEditingValue(
                      text: formattedValue,
                      selection: TextSelection.collapsed(
                        offset: formattedValue.length
                      )
                    );
                  widget.onChanged(currentValue);
                }
                 
              )
            ]
          )
        ]
      )
    );
  }
}

enum QuantityInputType {
  forInt,
  forDouble,
}