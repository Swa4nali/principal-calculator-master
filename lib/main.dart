import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple interest calculator app",
    home: SIForm(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SIFormState();
  }
}

class SIFormState extends State<SIForm> {
  var formKey=GlobalKey<FormState>();
  var currencies = ['Rupees', 'Dollars', 'Pounds'];
  final double minPadding = 5.0;

  var currentItemSelected = 'Rupees';

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Form(
        key: formKey,
          child: Padding(
              padding: EdgeInsets.all(minPadding * 2),
              child: ListView(
                children: <Widget>[
                  getImageAsset(),
                  Padding(
                      padding:
                          EdgeInsets.only(top: minPadding, bottom: minPadding),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: principalController,
                        validator:(String value){
                          if(value.isEmpty)
                            return 'Please enter Principal amount';
                        },
                        decoration: InputDecoration(
                            labelText: 'Principal',
                            hintText: 'Enter a principal e.g. 12000',
                            labelStyle: textStyle,
                            errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15.0
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding:
                          EdgeInsets.only(top: minPadding, bottom: minPadding),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: roiController,
                          validator:(String value){
                            if(value.isEmpty)
                              return 'Please enter Roi amount';
                          },
                        decoration: InputDecoration(
                            labelText: 'Rate of Interest',
                            hintText: 'In Percent',
                            labelStyle: textStyle,
                            errorStyle: TextStyle(
                                color: Colors.yellowAccent,
                                fontSize: 15.0
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding:
                          EdgeInsets.only(top: minPadding, bottom: minPadding),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: textStyle,
                            controller: termController,
                          validator:(String value){
                            if(value.isEmpty)
                              return 'Please enter term';
                          },
                            decoration: InputDecoration(
                                labelText: 'Term',
                                hintText: 'Time in years',
                                labelStyle: textStyle,
                                errorStyle: TextStyle(
                                    color: Colors.yellowAccent,
                                    fontSize: 15.0
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          )),
                          Container(
                            width: minPadding * 5,
                          ),
                          Expanded(
                              child: DropdownButton<String>(
                            items: currencies.map((String value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text(value));
                            }).toList(),
                            value: currentItemSelected,
                            onChanged: (String newValueSelected) {
                              onDropDownItemSelected(newValueSelected);
                            },
                          ))
                        ],
                      )),
                  Padding(
                      padding:
                          EdgeInsets.only(top: minPadding, bottom: minPadding),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            textColor: Theme.of(context).primaryColorDark,
                            child: Text(
                              'Calculate',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                if(formKey.currentState.validate()) {
                                  this.displayResult = calculateTotalReturns();
                                }
                              });
                            },
                          )),
                          Expanded(
                              child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              'Reset',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                reset();
                              });
                            },
                          ))
                        ],
                      )),
                  Padding(
                      padding:
                          EdgeInsets.only(top: minPadding, bottom: minPadding),
                      child: Text(
                        this.displayResult,
                        style: textStyle,
                      ))
                ],
              ))),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(minPadding * 10),
    );
  }

  void onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this.currentItemSelected = newValueSelected;
    });
  }

  String calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        'After $term years,your investment will be worth $totalAmountPayable $currentItemSelected';
    return result;
  }

  void reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    currentItemSelected = currencies[0];
  }
}
