import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: "Matt's Calculator Powered By Flutter"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _buttonPressed = false;
  String _display = '0';
  double _storedValue = 0;
  String _operator = '';
  bool _shouldResetDisplay = false;

  void _onNumberPressed(String number) {
    setState(() {
      if (_shouldResetDisplay) {
        _display = number;
        _shouldResetDisplay = false;
      } else {
        _display = _display == '0' ? number : _display + number;
      }
    });
  }

  void _onOperatorPressed(String op) {
    setState(() {
      _storedValue = double.parse(_display);
      _operator = op;
      _shouldResetDisplay = true;
    });
  }

  void _onEquals() {
    setState(() {
      if (_operator.isNotEmpty) {
        double secondValue = double.parse(_display);
        double result = 0;

        if (_operator == '+') {
          result = _storedValue + secondValue;
        } else if (_operator == '-') {
          result = _storedValue - secondValue;
        } else if (_operator == '*') {
          result = _storedValue * secondValue;
        } else if (_operator == '/') {
          result = _storedValue / secondValue;
        }

        _display = result.toStringAsFixed(secondValue == 0 && _operator == '/' ? 0 : 0);
        _operator = '';
        _shouldResetDisplay = true;
      }
    });
  }

  void _onClear() {
    setState(() {
      _display = '0';
      _storedValue = 0;
      _operator = '';
      _shouldResetDisplay = false;
    });
  }

  Widget _calcButton(String label, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(label, style: const TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: .center,
          children: [
            // Calculator Display
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _display,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            // Calculator Buttons
            Row(
              children: [
                _calcButton('7', () => _onNumberPressed('7')),
                _calcButton('8', () => _onNumberPressed('8')),
                _calcButton('9', () => _onNumberPressed('9')),
                _calcButton('/', () => _onOperatorPressed('/')),
              ],
            ),
            Row(
              children: [
                _calcButton('4', () => _onNumberPressed('4')),
                _calcButton('5', () => _onNumberPressed('5')),
                _calcButton('6', () => _onNumberPressed('6')),
                _calcButton('*', () => _onOperatorPressed('*')),
              ],
            ),
            Row(
              children: [
                _calcButton('1', () => _onNumberPressed('1')),
                _calcButton('2', () => _onNumberPressed('2')),
                _calcButton('3', () => _onNumberPressed('3')),
                _calcButton('-', () => _onOperatorPressed('-')),
              ],
            ),
            Row(
              children: [
                _calcButton('0', () => _onNumberPressed('0')),
                _calcButton('+', () => _onOperatorPressed('+')),
                _calcButton('=', _onEquals),
                _calcButton('C', _onClear),
              ],
            ),
            const SizedBox(height: 24),
            Text(_buttonPressed ? 'Hello World!' : 'Please press the button below.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _buttonPressed = true;
                  _counter++;
                });
              },
              child: const Text('Press Me'),
            ),
            const SizedBox(height: 32),
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
