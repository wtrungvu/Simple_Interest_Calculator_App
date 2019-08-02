import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Simple Interest Calculator",
      theme: ThemeData(
          primaryColor: Colors.blue,
          accentColor: Colors.blueAccent,
          brightness: Brightness.dark),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tính lãi suất"),
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
  var _currencies = ["VietNamDong", "Dollars", "Rupees", "Pounds"];
  var _currentItemSelected;

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  String displayResult = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
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
                    controller: principalController,
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        labelText: "Số tiền gốc ban đầu",
                        labelStyle: textStyle,
                        hintText: "Ví dụ: 50000đ",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(),
                        ),
                        prefixIcon: Icon(Icons.attach_money))),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: TextField(
                    controller: roiController,
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        labelText: "Số lãi suất",
                        labelStyle: textStyle,
                        hintText: "Ví dụ: 10%",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(),
                        ),
                        prefixIcon: Icon(Icons.rate_review))),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                          controller: termController,
                          style: textStyle,
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                              labelText: "Kỳ hạn",
                              hintText: "10 năm",
                              labelStyle: textStyle,
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide: new BorderSide(),
                              ),
                              prefixIcon: Icon(Icons.date_range))),
                    ),
                    Container(
                      width: 10,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        style: textStyle,
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String newValueSelected) {
                          _onDropDownItemSelected(newValueSelected);
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
                          child: Text(
                            "Tính",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              displayResult = _calculateInterested();
                            });
                          },
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
                          child: Text(
                            "Làm lại",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          color: Colors.red,
                          textColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              _onReseted();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "${displayResult}",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _calculateInterested() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = _logicCalculated(principal, roi, term);

    MoneyFormatterOutput fo = _formatCurrency(totalAmountPayable);

    return "Sau ${term.toString()} năm, bạn sẽ lãi ${fo.withoutFractionDigits} ${_currentItemSelected}";
  }

  double _logicCalculated(double principal, double roi, double term) {
    double totalAmountPayable = principal + (principal * roi * term) / 100;
    return totalAmountPayable;
  }

  MoneyFormatterOutput _formatCurrency(double totalAmountPayable) {
    MoneyFormatterOutput fo =
        FlutterMoneyFormatter(amount: totalAmountPayable).output;
    return fo;
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  void _onReseted() {
    principalController.clear();
    roiController.clear();
    termController.clear();
    displayResult = "";
    _currentItemSelected = _currencies[0]; // Default: VietNamDong
  }
}
