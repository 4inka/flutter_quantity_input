import 'package:flutter/material.dart';
import 'package:quantity_input/quantity_input.dart';

void main() {
  runApp(QuantityInputSample());
}

class QuantityInputSample extends StatefulWidget {
  @override
  State<QuantityInputSample> createState() => _QuantityInputSampleState();
}

class _QuantityInputSampleState extends State<QuantityInputSample> {
  int simpleIntInput = 1;
  int steppedIntInput = 1;
  double simpleDoubleInput = 1;
  double steppedDoubleInput = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Example')
          ),
          body: Center(
            child: Column(  
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Simple int input'
                ),
                QuantityInputAsInt(
                  value: simpleIntInput,
                  onChanged: (value) => setState(() => simpleIntInput = int.parse(value))
                ),
                Text(
                  'Value: $simpleIntInput',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(
                  height: 20
                ),
                Text(
                  'Simple double input'
                ),
                QuantityInputAsDouble(
                  //onInput: onInput,
                  value: simpleDoubleInput,
                  onButtonPress: (value) => setState(() => simpleDoubleInput += value),
                  onInput: (value) => setState(() => simpleDoubleInput = value)
                ),
                Text(
                  'Value: $simpleDoubleInput',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  )
                )
              ]
            )
          )
        )
      )
    );
  }
}
