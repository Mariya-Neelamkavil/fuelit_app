import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fuelit_app/login/LoginScreen.dart' as ls;



class TransactionTable extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget{
  @override
  _HomePageState createState(){
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  bool error = false, dataloaded = false;
  var data;
  String dataurl = "http://${ls.ip}/fuelit/TransactionTable.php"; //PHP script URL
  // do not use http://localhost/ for your local
  // machine, Android emulation do not recognize localhost
  // insted use your local ip address or your live URL
  // hit "ipconfig" on Windows or
  // "ip a" on Linux to get IP Address

  @override
  void initState() {
    loaddata();
    //calling loading of data
    super.initState();
  }

  void loaddata(){
    Future.delayed(Duration.zero,() async {
      var res = await http.post(Uri.parse(dataurl));
      if (res.statusCode == 200) {
        setState(() {
          data = json.decode(res.body);
          dataloaded = true;
          // we set dataloaded to true,
          // so that we can build a list only
          // on data load
        });
      }else{
        //there is error
        setState(() {
          error = true;
        });
      }
    });
    // we use Future.delayed becuase there is
    // async function inside it.
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title:Text("Transaction Summary"), //title of app
          backgroundColor: Colors.redAccent, //background color of app bar
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          //check if data is loaded, if loaded then show datalist on child
          child:dataloaded?datalist():
          Center( //if data is not loaded then show progress
              child:CircularProgressIndicator()
          ),
        )
    );
  }

  Widget datalist(){
    if(data["error"]){
      return Text(data["errmsg"]);
      //print error message from server if there is any error
    }else{
      List<NameOne> namelist = List<NameOne>.from(data["data"].map((i){
        return NameOne.fromJSON(i);
      })
      ); //prasing data list to model

      return Table( //if data is loaded then show table
        border: TableBorder.all(width:1, color:Colors.black45),
        children: namelist.map((nameone){
          return TableRow( //return table row in every loop
              children: [
                //table cells inside table row
                TableCell(child: Padding(
                    padding: EdgeInsets.all(5),
                    child:Text(nameone.fuel_consumption)
                )
                ),
                TableCell(child: Padding(
                    padding: EdgeInsets.all(5),
                    child:Text(nameone.amount)
                )
                )
              ]
          );
        }).toList(),
      );
    }
  }
}


class NameOne{
  String fuel_consumption,amount;

  NameOne({
    required this.fuel_consumption,
    required this.amount,
  });
  //constructor

  factory NameOne.fromJSON(Map<String, dynamic> json){
    return NameOne(
        fuel_consumption	: json["fuel_consumption"],
        amount: json["amount"]
    );
  }
}