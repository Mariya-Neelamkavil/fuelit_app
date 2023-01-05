// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuelit_app/Validation.dart';
import 'package:fuelit_app/userhome/homepage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fuelit_app/login/LoginScreen.dart' as ls;




// class QRBillEntry extends StatelessWidget {
//   String barcode;
//   QRBillEntry({Key? key,required this.barcode)} : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  MaterialApp(
//         theme: ThemeData(
//           primarySwatch:Colors.red, //primary color for theme
//         ),
//         home: WriteSQLdata(barcode: '',) //set the class here
//     );
//   }
// }

////////////////////////////////////////////////
///////////////////////////////////////////////

class QRBillEntry extends StatefulWidget{
  String barcode;
  QRBillEntry({Key? key,required this.barcode}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    print('Name: $barcode');
    return WriteSQLdataState();
  }
}


class WriteSQLdataState extends State<QRBillEntry>{
  Validation val = new Validation();
  TextEditingController fuelconsumption= TextEditingController();
  TextEditingController amount = TextEditingController();
  // text controller for TextField
 late  List<String> arr= widget.barcode.split(' ');

  String fuelconsumption_val = "";
  String amount_val = "";

  late bool error, sending, success;
  late String msg;

  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();
  }

  Future<void> sendData() async {


    String phpurl = "http://${ls.ip}/fuelit/ManualBillEntry.php";
    // fuelconsumption_val=arr[0];
    // amount_val=arr[1];
   // print(fuelconsumption_val);
    print(arr);
    print(arr[1]);


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
                        'QR Bill Entry',
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
                width: 300,
                child: Text(
                  fuelconsumption_val,
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 13,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: fuelconsumption,
                  decoration: InputDecoration(
                    labelText: arr[0],

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
                width: 300,

                child: Text(

                  amount_val,
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 13,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: amount,
                  decoration: InputDecoration(
                    labelText: arr.last,
                   // hintText: 'widget.barcode',
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

                            // print("barcode--   $barcodeScanRes");
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
  void validate() async
  {
    if(val.isNotNull(fuelconsumption.text))
      fuelconsumption_val="Email field cannot be empty";

    if (!val.isValidfloat(fuelconsumption.text))
      fuelconsumption_val="Enter valid value!!!";
    else fuelconsumption_val="";

    if(val.isNotNull(amount.text))
      amount_val="Email field cannot be empty";

    if (!val.isValidfloat(amount.text))
      amount_val="Enter valid value!!!";
    else amount_val="";


  }
}