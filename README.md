# Quantity Input (README to be finished)

<a href="https://www.buymeacoffee.com/4inka" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-violet.png" alt="Buy Me A Pizza" style="height: 60px !important;width: 217px !important;" ></a>


A Flutter plugin to handle number inputs with increment and decrement buttons.

## Preview
![Preview](https://raw.githubusercontent.com/4inka/quantity_input/main/preview/preview.gif?token=AK4B3SUGMN3BTBSKGO7VRYTBU6LK2)

## Usage

In the `pubspec.yaml` of your flutter project, add the following dependency:

``` yaml
dependencies:
  ...
  quantity_input: "^0.0.1"
```

You can create a simple quantity input widget with the following example:

``` dart
import 'package:flutter/material.dart';
import 'package:quantity_input/quantity_input.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int simpleIntInput = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
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
                  value: simpleIntInput,
                  onChanged: (value) => setState(() => simpleIntInput = int.parse(value.replaceAll(',', '')))
                ),
                Text(
                  'Value: $simpleIntInput',
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
```

## API
| Attribute | Type | Required | Description | Default value |
|:---|:---|:---:|:---|:---|
| value | `int`/`double` | :heavy_check_mark: | This is the description |  |
| onChanged | `Function(String)` | :heavy_check_mark: | This is the description |  |
| step | `int`/`double` | :x: | This is the description |  |

## Issues
If you encounter any issue you can report it by filling an [issue](https://github.com/4inka/flutter_quantity_input/issues).

## Contributing
Every pull request is welcome

Thank you for the support!