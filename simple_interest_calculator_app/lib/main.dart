import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Simple Interest Calculator",
      theme: ThemeData(accentColor: Colors.green),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: HomeScreenWidget(),
    );
  }
}

class HomeScreenWidget extends StatefulWidget {
  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  var _currencies = ["Dollars", "VietNamDong", "Rupees", "Pounds"];
  var _currentItemSelected = "VietNamDong";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(20.0),
          // color: Colors.black,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                child: Image(
                  width: 150,
                  height: 150,
                  image: AssetImage("images/interest.png"),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50.0),
                child: TextField(
                    decoration: new InputDecoration(
                  labelText: "Principal",
                  hintText: "Enter pricipal e.g. 12000",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: new BorderSide(),
                  ),
                )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: TextField(
                    decoration: new InputDecoration(
                  labelText: "Rate of Interest",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: new BorderSide(),
                  ),
                )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                          decoration: new InputDecoration(
                        labelText: "Term",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(),
                        ),
                      )),
                    ),
                    Container(
                      width: 10,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String newValueSelected) {
                          setState(() {
                            this._currentItemSelected = newValueSelected;
                          });
                        },
                        value: _currentItemSelected,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 50,
                        child: RaisedButton(
                          child: Text("Calculate"),
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Container(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        child: RaisedButton(
                          child: Text("Reset"),
                          color: Colors.black,
                          textColor: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: Text("Result will show here!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
