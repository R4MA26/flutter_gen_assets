import 'package:flu_gen/gen/assets.gen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Gen Assets'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  TextEditingController controller = TextEditingController();
  ValidateEnum state = ValidateEnum.notValid;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(width: 200, height: 200, child: Assets.test.image()),
            TextFieldCustom(
              isActive: true,
              controller: controller,
              state: state,
              onChanged: (value) {
                setState(() {
                  if (value.length >= 5) {
                    state = ValidateEnum.valid;
                  } else {
                    state = ValidateEnum.notValid;
                  }
                });
              },
            ),
            const SizedBox(
              height: 12,
            ),
            Assets.images.image.image()
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

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    Key? key,
    required this.controller,
    required this.state,
    required this.onChanged,
    this.isActive,
  }) : super(key: key);

  final TextEditingController controller;
  final ValidateEnum state;
  final Function(String)? onChanged;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        enabled: isActive ?? true,
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: 'Input Placeholder',
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: controller.text.length >= 5 ? Colors.green : Colors.red),
          ),
          suffixIcon: controller.text.isEmpty ? const SizedBox() : IconCustom(state: state),
        ),
      ),
    );
  }
}

enum ValidateEnum {
  notValid,
  valid,
}

class IconCustom extends StatelessWidget {
  const IconCustom({super.key, required this.state});

  final ValidateEnum state;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case ValidateEnum.notValid:
        return const Icon(Icons.warning);
      case ValidateEnum.valid:
        return const Icon(Icons.checklist);
    }
  }
}
