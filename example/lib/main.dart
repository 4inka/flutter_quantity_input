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
                QuantityInput(
                  label: 'Simple int input',
                  value: simpleIntInput,
                  onChanged: (value) => setState(() => simpleIntInput = value)
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
                QuantityInput(
                  label: 'Simple double input',
                  type: QuantityInputType.forDouble,
                  value: simpleDoubleInput,
                  decimalDigits: 2,
                  onChanged: (value) => setState(() => simpleDoubleInput = value)
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
