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
                  onChanged: (value) => setState(() => simpleIntInput = int.parse(value.replaceAll(',', '')))
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
                  label: 'Int input with 3 step',
                  value: steppedIntInput,
                  step: 3,
                  onChanged: (value) => setState(() => steppedIntInput = int.parse(value.replaceAll(',', '')))
                ),
                Text(
                  'Value: $steppedIntInput',
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
                  type: QuantityInputType.double,
                  value: simpleDoubleInput,
                  decimalDigits: 1,
                  onChanged: (value) => setState(() => simpleDoubleInput = double.parse(value.replaceAll(',', '')))
                ),
                Text(
                  'Value: $simpleDoubleInput',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(
                  height: 20
                ),
                QuantityInput(
                  label: 'Double input with 1.5 step',
                  type: QuantityInputType.double,
                  value: steppedDoubleInput,
                  step: 1.5,
                  decimalDigits: 1,
                  onChanged: (value) => setState(() => steppedDoubleInput = double.parse(value.replaceAll(',', '')))
                ),
                Text(
                  'Value: $steppedDoubleInput',
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
