import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: simplecalculator(),
    );
  }
}

class simplecalculator extends StatefulWidget {
  simplecalculator({Key? key}) : super(key: key);

  @override
  _simplecalculatorState createState() => _simplecalculatorState();
}

class _simplecalculatorState extends State<simplecalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('X', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 60.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      // ignore: deprecated_member_use
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white, width: 5, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Simple Calculator')),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                semanticsLabel: result,
                style: TextStyle(fontSize: equationFontSize),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(
                result,
                style: TextStyle(fontSize: resultFontSize),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(children: [
                    TableRow(children: [
                      buildButton('C', 1, Colors.black),
                      buildButton('⌫', 1, Colors.black),
                      buildButton('÷', 1, Colors.black),
                    ]),
                    TableRow(children: [
                      buildButton('7', 1, Colors.black),
                      buildButton('8', 1, Colors.black),
                      buildButton('9', 1, Colors.black),
                    ]),
                    TableRow(children: [
                      buildButton('4', 1, Colors.black),
                      buildButton('5', 1, Colors.black),
                      buildButton('6', 1, Colors.black),
                    ]),
                    TableRow(children: [
                      buildButton('1', 1, Colors.black),
                      buildButton('2', 1, Colors.black),
                      buildButton('3', 1, Colors.black),
                    ]),
                    TableRow(children: [
                      buildButton('.', 1, Colors.black),
                      buildButton('0', 1, Colors.black),
                      buildButton('00', 1, Colors.black),
                    ]),
                  ]),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(
                          children: [buildButton("X", 1, Colors.amberAccent)]),
                      TableRow(
                          children: [buildButton("-", 1, Colors.amberAccent)]),
                      TableRow(
                          children: [buildButton("+", 1, Colors.amberAccent)]),
                      TableRow(
                          children: [buildButton("=", 2, Colors.amberAccent)]),
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }
}
