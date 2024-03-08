import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'calculator app',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: const CalcView(),
    );
  }
}

////

/////////////////////////////////////////////////////////////////

Widget calcButton(
    String buttonText, Color buttonColor, void Function()? buttonPressed) {
  return Container(
    width: 75,
    height: 75,
    child: ElevatedButton(
      onPressed: buttonPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor),
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 18, color: Colors.greenAccent),
      ),
    ),
  );
}

class CalcView extends StatefulWidget {
  const CalcView({Key? key}) : super(key: key);

/////////////////////////////////////////////////////////////////

  @override
  State<CalcView> createState() => _CalcViewState();
}



class _CalcViewState extends State<CalcView> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 25.0;
  double resultFontSize = 25.0;



  buttonPressed(String buttonText) {
    String doesContainDecimal(dynamic result) {
      if (result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if (!(int.parse(splitDecimal[1]) > 0 )){
          return result = splitDecimal[0].toString();
        }
      }
      return result;
    }
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";

      }   else if  (buttonText == "del" ) {
        equation = equation.substring(0, equation.length - 1);
        if ( equation ==  "") {
          equation = "0";
        }
      } else if (buttonText == "+/-") {
        if (equation[0] != '-') {
          equation = '-$equation';
        } else {
          equation = equation.substring(1);
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '%');


        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          if (expression.contains('%')) {
            result = doesContainDecimal(result);
          }


        } catch (e) {
          result = "nuh uh";
        }

      }
      else {
        if (equation == "0") {
          equation = buttonText;
        }
        else {
          equation = equation + buttonText;
        }
      }

    });




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.greenAccent,
        leading: const Icon(Icons.calculate, color: Colors.deepPurple,size: 60,),
        actions: const [

          Padding(

            padding: EdgeInsets.only(top: 18.0),

            child: Text('Kalkulator prosty', style: TextStyle(color: Colors.deepPurple,fontSize: 15)),
          ),
          SizedBox(width: 20),

        ],

      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    Row(

                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(10.0),

                            child: Text(result,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Colors.deepPurple, fontSize: 35))),
                        const SizedBox(width: 20),
                      ],
                    ),
                    Row(


                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        Padding(
                          padding: const EdgeInsets.all(20),

                          child: Text(equation,

                              style: const TextStyle(
                                fontSize: 20,
                                overflow: TextOverflow.ellipsis,

                                color: Colors.deepPurple,

                              )),
                        ),


                        const SizedBox(width: 20),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                calcButton('AC', Colors.deepPurple, () => buttonPressed('AC')),
                calcButton('%', Colors.deepPurple, () => buttonPressed('%')),
                calcButton('÷', Colors.deepPurple, () => buttonPressed('÷')),
                calcButton("×", Colors.deepPurple, () => buttonPressed('×')),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('7', Colors.deepPurple, () => buttonPressed('7')),
                calcButton('8', Colors.deepPurple, () => buttonPressed('8')),
                calcButton('9', Colors.deepPurple, () => buttonPressed('9')),
                calcButton('-', Colors.deepPurple, () => buttonPressed('-')),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('4', Colors.deepPurple, () => buttonPressed('4')),
                calcButton('5', Colors.deepPurple, () => buttonPressed('5')),
                calcButton('6', Colors.deepPurple, () => buttonPressed('6')),
                calcButton('+', Colors.deepPurple, () => buttonPressed('+')),
              ],
            ),
            const SizedBox(height: 10),
            // calculator number buttons

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('1', Colors.deepPurple, () => buttonPressed('1')),
                calcButton('2', Colors.deepPurple, () => buttonPressed('2')),
                calcButton('3', Colors.deepPurple, () => buttonPressed('3')),
                calcButton('=', Colors.deepPurple, () => buttonPressed('=')),
              ],
            ),
            const SizedBox(height: 10),
            // calculator number buttons

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('+/-', Colors.deepPurple, () => buttonPressed('+/-')),
                calcButton('0', Colors.deepPurple, () => buttonPressed('0')),
                calcButton('.', Colors.deepPurple, () => buttonPressed('.')),
                calcButton('⌫', Colors.deepPurple, () => buttonPressed('del')),
              ],
            ),
            const SizedBox(height: 20),
            // calculator number buttons

          ],
        )
        ,

      ),

    );
  }
}



