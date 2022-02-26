// Copyright 2021 4inka

// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:

// 1. Redistributions of source code must retain the above copyright notice,
// this list of conditions and the following disclaimer.

// 2. Redistributions in binary form must reproduce the above copyright
// notice, this list of conditions and the following disclaimer in the
// documentation and/or other materials provided with the distribution.

// 3. Neither the name of the copyright holder nor the names of its contributors
// may be used to endorse or promote products derived from this software without
// specific prior written permission.

// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
// IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
// INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
// NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
// PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

library quantity_input;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:quantity_input/widgets/icon-button.widget.dart';

/// quantity input type
/// [int] default mask type, to format value as int
/// [double] to format value as double
enum QuantityInputType {
  int,
  double,
}

class QuantityInput extends StatefulWidget {
  /// Has to be an int or double depending on QuantityInputType variable
  final dynamic value;
  /// Detects changes to the input and sends value through param
  final Function(String) onChanged;
  /// The value that is incremented or decremented each time the user presses a button
  final dynamic step;
  /// The number of decimal places that can be displayed for double input
  final int decimalDigits;
  /// Set min value to be displayed in input
  final dynamic minValue;
  /// Set max value to be displayed in input
  final dynamic maxValue;
  /// The width of the textfield input
  final double inputWidth;
  /// Sets color for increment and decrement buttons
  final Color? buttonColor;
  /// Sets color for icons inside increment and decrement buttons
  final Color? iconColor;
  /// Sets label for input
  final String label;
  /// Determines if the input will be readOnly
  final bool readOnly;
  /// If set to true, the input can accept the value 0
  final bool acceptsZero;
  /// If set to true, the input can accept negative values
  final bool acceptsNegatives;
  /// Determines if the input will manage values as int or double
  final QuantityInputType? type;
  /// Sets custom InputDecoration to the widget TextFormField
  final InputDecoration? decoration;
  /// Sets elevation to increment and decrement buttons
  final double elevation;

  /// Creates a widget that can be used to manage number inputs
  /// 
  /// Widget can manage integer or double values
  QuantityInput({
    required this.value,
    required this.onChanged,
    this.step = 1,
    this.decimalDigits = 1,
    this.buttonColor,
    this.iconColor,
    this.label = '',
    this.readOnly = false,
    this.acceptsNegatives = false,
    this.acceptsZero = false,
    this.minValue = 1,
    this.maxValue = 100000,
    this.type = QuantityInputType.int,
    this.inputWidth = 80,
    this.decoration,
    this.elevation = 5
  })
    : assert(decimalDigits > 0, 'Decimal digits cannot be set to zero or negative value'),
     assert(!(acceptsZero && acceptsNegatives), 'acceptsZero and acceptsNegatives cannot be simultaneously true');

  @override
  _QuantityInputState createState() => _QuantityInputState();
}

class _QuantityInputState extends State<QuantityInput> {
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = valueFormatter(widget.value);
  }

  String valueFormatter(dynamic value) {
    String extraZeros = '';

    if(widget.decimalDigits > 0 && widget.type == QuantityInputType.double) {
      extraZeros = '.';
      extraZeros = extraZeros.padRight(widget.decimalDigits + 1, '0');
    }

    NumberFormat formatter = NumberFormat('#,###,###,###,###,###,###,###,###,##0$extraZeros', 'en_US');
    
    return formatter.format(value);
  }

  String parseNewDouble(String value) {
    String fullPartOfDouble = value.substring(0, value.length - widget.decimalDigits);
    String decimalPartOfDouble = value.substring(value.length - widget.decimalDigits);
    String newFullValue = '$fullPartOfDouble.$decimalPartOfDouble';

    return newFullValue;
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
              )
            )
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
                elevation: widget.elevation,
                onTap: () {
                  dynamic currentValue = 0;

                  if (widget.acceptsNegatives ||
                    ((widget.value - widget.step) > 0 && widget.type == QuantityInputType.double) ||
                    ((widget.value - widget.step) >= 1 && widget.type == QuantityInputType.int) ||
                    (widget.acceptsZero && (widget.value - widget.step) == 0))
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
                  widget.onChanged(formattedValue);
                }
              ),
              Container(
                height: 38,
                width: widget.inputWidth,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: TextFormField(
                    controller: _controller,
                    textAlign: TextAlign.center,
                    decoration: widget.decoration,
                    readOnly: widget.readOnly,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        String simpleValue = '';
                        String formattedValue = '';
                        if (newValue.text.contains(RegExp(r'[a-zA-Z]')))
                          return oldValue;

                        if (widget.type == QuantityInputType.double) {
                          simpleValue = newValue.text.replaceAll(',', '').replaceAll('.', '');

                          if (simpleValue.length == 1) {
                            simpleValue = simpleValue.padLeft(1, '0');
                          }

                          formattedValue = valueFormatter(double.parse(parseNewDouble(simpleValue)));
                        }
                        else {
                          if(newValue.text.isEmpty)
                            formattedValue = '0';
                          else {
                            simpleValue = newValue.text.replaceAll(',', '');

                            formattedValue = valueFormatter(int.parse(simpleValue));
                          }
                        }

                        return TextEditingValue(
                          text: formattedValue,
                          selection: TextSelection.collapsed(
                            offset: formattedValue.length
                          )
                        );
                      })
                    ],
                    onChanged: (value) => widget.onChanged(value)
                  )
                )
              ),
              IconButtonWidget(
                icon: Icons.add,
                iconColor: widget.iconColor,
                buttonColor: widget.buttonColor,
                elevation: widget.elevation,
                onTap: () {
                  dynamic currentValue = 0;

                  if (widget.maxValue >= widget.value && widget.maxValue >= widget.value + widget.step) {
                      currentValue = widget.value + widget.step;
                    }
                  else {
                    currentValue = widget.value;
                  }

                  String formattedValue = valueFormatter(currentValue);
                  _controller
                    ..value = TextEditingValue(
                      text: formattedValue,
                      selection: TextSelection.collapsed(
                        offset: formattedValue.length
                      )
                    );
                  widget.onChanged(formattedValue);
                }
              )
            ]
          )
        ]
      )
    );
  }
}