import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:syntax_highlighter/syntax_highlighter.dart'
    hide SyntaxHighlighter;

const exampleMarkdown = '''
# h1 text

## h2 text

Some **text** is very *important*.

```dart
class CoolClass {
  final String field;
}
```

''';

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

class ImplicitDartSyntaxHighlighter implements SyntaxHighlighter {
  const ImplicitDartSyntaxHighlighter(this.formatter);

  final DartSyntaxHighlighter formatter;

  @override
  TextSpan format(String source) {
    return formatter.format(source);
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
          child: MarkdownBody(
            data: exampleMarkdown,
            syntaxHighlighter: ImplicitDartSyntaxHighlighter(
              DartSyntaxHighlighter(
                SyntaxHighlighterStyle.lightThemeStyle(),
              ),
            ),
          ),
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
