import 'package:flutter/material.dart';
//import 'package:flutter_calculator/Button.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String data = "";
  double ans;
  double n1 = 0.0;
  double n2 = 0.0;
  String operand = '';
  int start=0;

  void pressed(String s){
    if(s != "AC" && s !="backspace" && s != "equal"){
      if(s=="x" || s=="/" || s=="+" || s=="-"){
        setState(() {
          n1 = n1 == 0.00 ?double.parse(data) : n1 = ans ;
          data+=s;
          operand = s;
          start = data.length;
        });
      }else if(s=='%') {
        setState(() {
          if(operand == '') {
            if (n1 == 0.00 || n1 == null || n1 == 0.0)
              n1 = double.parse(data);
            else
              n1 = ans ;
            n1 = n1 / 100.00;
            data = n1.toString();
            ans = double.parse(data);
          }else{
            String temp = data.substring(start);
            n2 = double.parse(temp);
            n2 = n2/100.00;
            String x = n2.toString();
            data = data.substring(0,start) + x;
          }
        });
      }else {
        setState(() {
          data += s;
        });
      }
    }else{
      if(s == "AC"){
        setState((){
          data="";
          ans = 0.00;
          n1 = 0.00;
          n2 = 0.00;
          operand = "";
        });
      }
      if(s == "backspace"){
        setState(() {
          data=data.substring(0,data.length-1);
        });
      }
      if(s=="equal"){
        setState(() {
          String temp = data.substring(start);
          n2 = double.parse(temp);
          print(n2);
          switch(operand){
            case "/":
              ans = n1/n2;
              break;
            case "x":
              ans = n1*n2;
              break;
            case "+":
              ans = n1+n2;
              break;
            case "-":
              ans = n1-n2;
              break;
          }
        });
      }
    }
  }

  Widget Button(String string){
  return new SizedBox(
      width: (MediaQuery.of(context).size.width / 4.00) - 0.75,
      height: 70.00,
      child: new FlatButton(
        onPressed:()=> pressed(string),
        child: Text(
          string,
          style: TextStyle(fontSize: 25.00, color: Colors.blueGrey),
        ),
        color: Colors.white,
        highlightColor: Colors.grey.withOpacity(0.1),
        splashColor: Colors.grey.withOpacity(0.1),
      ));
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.lightBlueAccent.withOpacity(0.05),
        child: Column(mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 30.00,),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new SizedBox(width: deviceSize.width,child: new Text(ans.toString(),style: TextStyle(fontSize: 55.00,color: Colors.black,),textDirection: TextDirection.rtl,)),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: new SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new SizedBox(width: deviceSize.width,child: new Text(data ,style: TextStyle(fontSize: 45.00,color: Colors.black.withOpacity(0.70),),)),
                ),
              ),
            ),
            new Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    new SizedBox(width: (deviceSize.width/4.00) - 0.75,height: 70.00,child: new FlatButton(onPressed: () => pressed("AC") , child: Text("AC",style: TextStyle(fontSize: 25.00,color: Colors.deepOrange),),color: Colors.white,highlightColor: Colors.grey.withOpacity(0.1),splashColor: Colors.grey.withOpacity(0.1),)),
                    new SizedBox(height: 1.00,),
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
                    new SizedBox(width: (deviceSize.width/4.00) - 0.75,height: 70.00,child: new FlatButton(onPressed: () => pressed("backspace") , child: Icon(Icons.backspace,color: Colors.blueGrey,),color: Colors.white,highlightColor: Colors.grey.withOpacity(0.1),splashColor: Colors.grey.withOpacity(0.1),)),
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
                    new SizedBox(width: (deviceSize.width/4.00) - 0.75,height: 141.00,child: new FlatButton(onPressed: () => pressed("equal") , child: Text("=",style: TextStyle(fontSize:30.00,color: Colors.white),),color: Colors.deepOrange,highlightColor: Colors.deepOrange.withOpacity(0.1),splashColor: Colors.deepOrange.withOpacity(0.1),)),
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