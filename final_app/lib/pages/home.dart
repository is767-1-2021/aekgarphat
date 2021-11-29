import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculators extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculators> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) async {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 20.0;
        resultFontSize = 48.0;
      } 
        else if (buttonText == "CE") {
        equation = "0";
        equationFontSize = 20.0;
        resultFontSize = 48.0;
       }
        else if (buttonText == "⌫") {
        equationFontSize = 20.0;
        resultFontSize = 48.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } 
        else if (buttonText == "=") {
        equationFontSize = 20.0;
        resultFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('+/-', '-');
        expression = expression.replaceAll('%', '/100');
        expression = expression.replaceAll('1/X', '^-1');
        expression = expression.replaceAll('X²', '^2');
        expression = expression.replaceAll('²√X', '^(1/2)');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 20.0;
        resultFontSize = 48.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
    if (expression.isNotEmpty){
      if (buttonText == "=") {
        await FirebaseFirestore.instance.collection('history').doc().set({"expression":expression,"result":result,"created_at":DateTime.now()});
      }
    }
  }


  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        color: buttonColor,
        child: TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
        ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: (ModalRoute.of(context)?.canPop ?? false) ? BackButton() : null,
        title: Row(
          children: <Widget>[
            Text('Standard   '),
            IconButton(icon: Icon(Icons.add_to_home_screen), onPressed: () {}),
          ],
        ),
      ),
      drawer: NavigationDrawerWidget(),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize, color: Colors.grey),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize, color: Colors.white),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.04,
                child: Table(
                  border: TableBorder.all(color: Colors.blueGrey.shade800, width: 1),
                  children: [
                    TableRow(children: [
                      Text("MC",style: TextStyle(color: Colors.grey, fontSize: 20), textAlign: TextAlign.center),
                      Text("MR",style: TextStyle(color: Colors.grey, fontSize: 20), textAlign: TextAlign.center),
                      Text("M+",style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center),
                      Text("M-",style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center),
                      Text("MS",style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center),
                    ]),
                  ]),
          )]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 1,
                child: Table(
                  border: TableBorder.all(color: Colors.blueGrey.shade800, width: 2.5),
                  children: [
                    TableRow(children: [
                      buildButton("%", 1, Colors.black54),
                      buildButton("CE", 1, Colors.black54),
                      buildButton("C", 1, Colors.black54),
                      buildButton("⌫", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton("1/X", 1, Colors.black54),
                      buildButton("X²", 1, Colors.black54),
                      buildButton("²√X", 1, Colors.black54),
                      buildButton("÷", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.black),
                      buildButton("8", 1, Colors.black),
                      buildButton("9", 1, Colors.black),
                      buildButton("×", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.black),
                      buildButton("5", 1, Colors.black),
                      buildButton("6", 1, Colors.black),
                      buildButton("-", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.black),
                      buildButton("2", 1, Colors.black),
                      buildButton("3", 1, Colors.black),
                      buildButton("+", 1, Colors.black54),
                    ]),
                    TableRow(children: [
                      buildButton("+/-", 1, Colors.black),
                      buildButton("0", 1, Colors.black),
                      buildButton(".",1, Colors.black),
                      buildButton("=", 1, Colors.blue),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
