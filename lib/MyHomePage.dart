import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String data = "";
  double ans =0.0;
  String operand = '';
  int start=0;
  Parser parser = new Parser();
  Expression expression;
  String equation = "";

  void pressed(String s){
    if(s != "AC" && s !="backspace" && s != "equal"){
      if(s=="x" || s=="÷" || s=="+" || s=="-"){
        setState(() {
          data+=s;
          start = data.length;
          operand = s;
        });
        if(s=='x')
          s='*';
        if(s=='÷')
          s='/';
        //
        equation +=s;
      }else if(s=='%') {
        setState(() {
          if(operand == '') {
            print("yess");
            ans = double.parse(data)/100;
            data = ans.toString();
            equation = data;
          }else{
            String temp = data.substring(start);
            print("its temp"+temp);
            print(start);
            String per = data.substring(0,start-1);
            print(per);
            expression = parser.parse(per);
            double p = expression.evaluate(EvaluationType.REAL, null );

            double n2 = double.parse(temp);
            print(n2);
            n2 = n2/100.00*p;
            String x = n2.toString();
            data = data.substring(0,start) + x;
            //
            equation = data;
          }
        });
      }else {
        setState(() {
          data += s;
        });
        equation += s;
      }
    }else{
      if(s == "AC"){
        setState((){
          data="";
          ans = 0.00;
          operand = "";
          equation = "";
        });
      }
      if(s == "backspace"){
        setState(() {
          if(data!="") {
            data = data.substring(0, data.length - 1);
            equation = equation.substring(0, equation.length - 1);
          }
          });
      }
      if(s=="equal"){
        setState(() {
          data="";
          print(equation);
          expression = parser.parse(equation);
          print("Expression is "+ expression.toString());
          ans = expression.evaluate(EvaluationType.REAL, null );
        });
      }
    }
    setState(() {
      try{
        expression = parser.parse(equation);
        ans = expression.evaluate(EvaluationType.REAL, null );
      }catch(e){

      }
    });
  }

  Widget Button(String string){
    return new SizedBox(
      width: (MediaQuery.of(context).size.width / 4.00) - 0.75,
      height: 70.00,
      child: new FlatButton(
        onPressed:()=> pressed(string),
        child: Text(
          string,
          style: TextStyle(fontSize: 25.00, color: Color.fromRGBO(111, 116, 128, 1.00)),
        ),
        color: Color.fromRGBO(255, 255, 255, 1.00),
        highlightColor: Color(0xFFE1E1E2),
        splashColor: Color(0xFFE1E1E2),
      ));
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(241,243,243,1.00),
        child: Column(mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 30.00,),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new SizedBox(width: deviceSize.width,child: new Text(ans.toString(),style: TextStyle(fontSize: 55.00,color: Color.fromRGBO(24, 24, 24, 1.00),),textDirection: TextDirection.rtl,)),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: new SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new SizedBox(width: deviceSize.width,child: new Text(data ,style: TextStyle(fontSize: 45.00,color: Color.fromRGBO(168, 170, 170, 1.00),),)),
                ),
              ),
            ),
            new Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    new SizedBox(width: (deviceSize.width/4.00) - 0.75,height: 70.00,child: new FlatButton(onPressed: () => pressed("AC") , child: Text("AC",style: TextStyle(fontSize: 25.00,color: Color.fromRGBO(255, 93, 0, 1.00)),),color: Color.fromRGBO(255, 255, 255, 1.00),highlightColor: Color(0xFFE1E1E2),splashColor: Color(0xFFE1E1E2),)),
                    //Color not visible
                    new SizedBox(height: 1.00,child: Container(color: Color.fromRGBO(195, 197, 198, 1.00),),),
                    Button("7"),
                    new SizedBox(height: 1.00,),
                    Button("4"),
                    new SizedBox(height: 1.00,),
                    Button("1"),
                    new SizedBox(height: 1.00,),
                    Button("%"),
                  ],
                ),
                new SizedBox(width: 1.00,),
                Column(
                  children: <Widget>[
                    new SizedBox(width: (deviceSize.width/4.00) - 0.75,height: 70.00,child: new FlatButton(onPressed: () => pressed("backspace") , child: Icon(Icons.backspace,color: Color.fromRGBO(111, 116, 128, 1.00),),color: Color.fromRGBO(255, 255, 255, 1.00),highlightColor: Color(0xFFE1E1E2),splashColor: Color(0xFFE1E1E2),)),
                    new SizedBox(height: 1.00,),
                    Button("8"),
                    new SizedBox(height: 1.00,),
                    Button("5"),
                    new SizedBox(height: 1.00,),
                    Button("2"),
                    new SizedBox(height: 1.00,),
                    Button("0"),
                  ],
                ),
                new SizedBox(width: 1.00,),
                Column(
                  children: <Widget>[
                    Button("÷"),
                    new SizedBox(height: 1.00,),
                    Button("9"),
                    new SizedBox(height: 1.00,),
                    Button("6"),
                    new SizedBox(height: 1.00,),
                    Button("3"),
                    new SizedBox(height: 1.00,),
                    Button("."),
                  ],
                ),
                new SizedBox(width: 1.00,),
                Column(
                  children: <Widget>[
                    Button("x"),
                    new SizedBox(height: 1.00,),
                    Button("-"),
                    new SizedBox(height: 1.00,),
                    Button("+"),
                    new SizedBox(height: 1.00,),
                    new SizedBox(width: (deviceSize.width/4.00) - 0.75,height: 141.00,child: new FlatButton(onPressed: () => pressed("equal") , child: Text("=",style: TextStyle(fontSize:30.00,color: Color.fromRGBO(255, 255, 255, 1.00)),),color: Color.fromRGBO(251, 119, 48, 1.00),highlightColor: Color.fromRGBO(224, 106, 43, 1.00),splashColor: Color.fromRGBO(224, 106, 43, 1.00),)),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}