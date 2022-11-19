import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuelit_app/userhome/homepage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dart_ipify/dart_ipify.dart';



class ManualBillEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
         theme: ThemeData(
            primarySwatch:Colors.red, //primary color for theme
         ),
         home: WriteSQLdata() //set the class here
    );
  }
}

////////////////////////////////////////////////
///////////////////////////////////////////////

class WriteSQLdata extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return WriteSQLdataState();
  }
}


class WriteSQLdataState extends State<WriteSQLdata>{

  TextEditingController fuelconsumption= TextEditingController();
  TextEditingController amount = TextEditingController();
  // text controller for TextField

  late bool error, sending, success;
  late String msg;
  // do not use http://localhost/ for your local
  // machine, Android emulation do not recognize localhost
  // insted use your local ip address or your live URL
  // hit "ipconfig" on Windows or  "ip a" on Linux to get IP Address

  @override
  void initState() {
      error = false;
      sending = false;
      success = false;
      msg = "";
      super.initState();
  }

  Future<void> sendData() async {

    
  final ipv4 = await Ipify.ipv4();
  String phpurl = "http://"+ipv4+"/ManualBillEntry.php";

     var res = await http.post(Uri.parse(phpurl), body: { 
          "dbfuelconsumption": fuelconsumption.text,
          "dbamount": amount.text,
      }); //sending post request with header data

     if (res.statusCode == 200) {
       print("RES.BODY:::" + res.body); //print raw response on console
       var data = json.decode(res.body); //decoding json to array
       if(data["error"]){
          setState(() { //refresh the UI when error is received from server
             sending = false;
             error = true;
             msg = data["message"]; //error message from server
          });
       }else{
         
         fuelconsumption.text = "";
         amount.text = "";
         //after write success, make fields empty

          setState(() {
             sending = false;
             success = true; //mark success and refresh UI with setState
          });
       }
       
    }else{
       //there is error
        setState(() {
            error = true;
            msg = "Error during sending data.";
            sending = false;
            //mark error and refresh UI with setState
        });
    }
  }




 
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Manual Bill Entry',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: fuelconsumption,
                  decoration: InputDecoration(
                    hintText: 'Enter Fuel Consumption',
                    suffixIcon: Icon(Icons.add),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: amount  ,
                  decoration: InputDecoration(
                    hintText: 'Enter Amount of Bill',
                    suffixIcon: Icon(Icons.add_chart),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Date & Time',
                    suffixIcon: Icon(Icons.timelapse),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: ElevatedButton(
                          child: Text('Add Bill'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffEE7B23)),
                          onPressed: () { //if button is pressed, setstate sending = true, so that we can show "sending..."
                          setState(() {
                             sending = true;
                          });
                          sendData();
                          
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => homepage()));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
