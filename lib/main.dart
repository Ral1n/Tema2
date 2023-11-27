import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String enteredText = '';
  int randomNumber = 0;
  bool showText1 = false;
  bool showText2 = false;

  void generateRandomNumber() {
    Random random = Random();
    int newRandomNumber = random.nextInt(100) + 1;
    setState(() {
      randomNumber = newRandomNumber;
    });
  }

  @override
  void initState() {
    super.initState();
    generateRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess my number'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: <Widget>[
          Text('$randomNumber'),
          const Text(
            'I am thinking of a number between 1 and 100',
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'It is your turn to guess my number!',
            style: TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 50,
          ),
          Stack(alignment: Alignment.center, children: [
            Visibility(
              visible: showText1,
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Text(
                  'Too low! Try a higher number.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: showText2,
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Text(
                  'Too high! Try a lower number.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: 600,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ]),
                child: Column(
                  children: [
                    const Text(
                      'Try a number!',
                      style: TextStyle(fontSize: 40, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      onChanged: (value) {
                        setState(() {
                          enteredText = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Pick a number',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            int? valoareCastigatoare = int.tryParse(enteredText) ?? 0;
                            if (valoareCastigatoare == randomNumber) {
                              showText1 = false;
                              showText2 = false;
                              showDialog(
                                  context: context,
                                  builder: (building) {
                                    return AlertDialog(
                                      title: Text('You guessed right!'),
                                      content: Text('It was ${valoareCastigatoare.toString()}.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            generateRandomNumber();
                                          },
                                          child: Text('Try Again! '),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  });
                            } else if (valoareCastigatoare < randomNumber) {
                              showText1 = true;
                              showText2 = false;
                            } else if (valoareCastigatoare > randomNumber) {
                              showText2 = true;
                              showText1 = false;
                            }
                          });
                        },
                        child: const Text('Guess')),
                  ],
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
