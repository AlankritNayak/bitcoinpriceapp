import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var inputController = TextEditingController();
  var outputController = TextEditingController();
  final String url = "https://blockchain.info/tobtc?currency=INR&value=500";
  var data;
  var warning = "";

   onButtonPressed() {
    if(inputController.text == ""){
      warning = "Please enter value";
    }
    setState(() {

      var number = double.tryParse(inputController.text);
      outputController.text = (number * data).toString();     
    });
  }

  @override
  void initState() {
    super.initState();
    this.getjsondata();
  }

  Future<String> getjsondata() async {
    var responce = await http.get(Uri.encodeFull(url));
    setState(() {
      var convertdatatojson = json.decode(responce.body);
      data = convertdatatojson;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold( 
    appBar: AppBar(
      backgroundColor: Colors.red,
      title: Text("Converter App"),
    ),
    body : Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
            Container(
              child: Image(image: AssetImage('assets/bitcoin.png'),
              fit: BoxFit.fitWidth,
              height: 250,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:5),
              child: Container(
                margin: EdgeInsets.only(top: 100.0, right: 25.0, left: 25.0),
                child: TextField(
                  controller: inputController,
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: Colors.red,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    hintText: "Enter Amount in INR",
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 40),
              child: MaterialButton(
                onPressed: () {
                  onButtonPressed();
                },
                child: Icon(Icons.cached, color: Colors.white70, size: 50,),
                color: Colors.red,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Container(
                margin: EdgeInsets.only(top: 20.0, right: 25.0, left: 25.0),
                child: TextField(
                  controller: outputController,
                  enabled: false,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                  ),
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.cached,
                      color: Colors.red,
                    ),
                    hintText: "Converted Amount",
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    )
    );
  }
}