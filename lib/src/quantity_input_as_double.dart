import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:quantity_input/widgets/icon-button.widget.dart';

class QuantityInputAsDouble extends StatefulWidget {
  final double value, step;
  /// Set min value to be displayed in input. If not set, it will be set to 1
  final double minValue;
  final int decimalDigits;
  /// ```dart
  /// min(5, 3) == 3
  /// ```
  final Function(String) onChanged;
  final Color? buttonColor, iconColor;
  final String label;
  final bool readOnly;
  /// Default to false
  /// 
  /// Setting property to true enables the option to display negative values
  final bool acceptsNegatives;
  final TextEditingController? controller;

  /// Test widget 1
  QuantityInputAsDouble({
    this.value = 1,
    this.step = 1,
    required this.onChanged,
    this.buttonColor,
    this.iconColor,
    this.label = '',
    this.readOnly = false,
    this.acceptsNegatives = false,
    this.minValue = 1,
    this.controller,
    this.decimalDigits = 1
  });

  @override
  _QuantityInputAsDoubleState createState() => _QuantityInputAsDoubleState();
}

class _QuantityInputAsDoubleState extends State<QuantityInputAsDouble> {
  late TextEditingController _controller;

  String valueFormatter(double value) {
    NumberFormat formatter = NumberFormat("#,###,###,###,###,###,###,###,###,##0.0", "en_US");
    
    return formatter.format(value);
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? new TextEditingController();
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
                  double currentValue = 0;

                  if (widget.acceptsNegatives || (widget.value - widget.step) > 0)
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

                  widget.onChanged(currentValue.toString());
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

                        String simpleValue = newValue.text.replaceAll(',', '').replaceAll('.', '');

                        if (simpleValue.length == 1) {
                          simpleValue = simpleValue.padLeft(1, '0');
                        }

                        String fullPartOfDouble = simpleValue.substring(0, simpleValue.length - 1);
                        String decimalPartOfDouble = simpleValue.substring(simpleValue.length - 1);
                        String newFullValue = '$fullPartOfDouble.$decimalPartOfDouble';

                        String formattedValue = valueFormatter(double.parse(newFullValue));

                        print(formattedValue);
                        return TextEditingValue(
                          text: formattedValue,
                          selection: TextSelection.collapsed(
                            offset: formattedValue.length
                          )
                        );
                      })
                    ],
                    onChanged: (value) => widget.onChanged(value.replaceAll(',', ''))
                  )
                )
              ),
              IconButtonWidget(
                icon: Icons.add,
                iconColor: widget.iconColor,
                buttonColor: widget.buttonColor,
                onTap: () {
                  double currentValue = widget.value + widget.step;
                  String formattedValue = valueFormatter(currentValue);
                  _controller
                    ..value = TextEditingValue(
                      text: formattedValue,
                      selection: TextSelection.collapsed(
                        offset: formattedValue.length
                      )
                    );
                  widget.onChanged(currentValue.toString());
                }
                 
              )
            ]
          )
        ]
      )
    );
  }
}