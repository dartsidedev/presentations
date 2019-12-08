import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: KeyboardDetector(),
    );
  }
}

class KeyboardDetector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => KeyboardDetectorState();
}

class KeyboardDetectorState extends State<KeyboardDetector> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      FocusScope.of(context).requestFocus(focusNode);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Hello'),
        ),
        body: Center(
          child: Text('Vince'),
        ),
      ),
      focusNode: focusNode,
      onKey: (a) {
        if (a is RawKeyDownEvent) {
          if (a.data is RawKeyEventDataMacOs) {
            final keyCode = (a.data as RawKeyEventDataMacOs).keyCode;
            if (keyCode == 124) {
              print('NEXT');
            }
            if (keyCode == 123) {
              print('PREVIOUS');
            }
          }
        }
      },
    );
  }
}
