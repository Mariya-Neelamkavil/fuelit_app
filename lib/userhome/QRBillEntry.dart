import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fuelit_app/Validation.dart';
import 'package:fuelit_app/userhome/homepage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fuelit_app/login/LoginScreen.dart' as ls;

class QRBillEntry extends StatefulWidget{
  String barcode;
  QRBillEntry({Key? key,required this.barcode}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WriteSQLdataState();
  }
}


class WriteSQLdataState extends State<QRBillEntry>{
  Validation val = new Validation();
  TextEditingController dateinput = TextEditingController();
  TextEditingController fuelconsumption= TextEditingController();
  TextEditingController amount = TextEditingController();
  // text controller for TextField
  late  List<String> arr= widget.barcode.split('\n');

  String fuelconsumption_val = "";
  String amount_val = "";
  String date_val="";
  // String now = DateFormat("yyyy-MM-dd").format(DateTime.now());
  late bool error, sending, success;
  late String msg;

  @override
  void initState() {
    dateinput.text = "";
    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();
    fuelconsumption.text=arr.first;
    amount.text=arr.last;
  }

  Future<void> sendData() async {


    String phpurl = "http://${ls.ip}/fuelit/ManualBillEntry.php";
    // fuelconsumption_val=arr[0];
    // amount_val=arr[1];
    // print(fuelconsumption_val);


    var res = await http.post(Uri.parse(phpurl), body: {
      "dbfuelconsumption": arr.first,
      "dbamount": arr.last,
      "dbdate": dateinput.text,
      "dbuid": ls.uid.toString(),
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
                   // labelText: arr.first,

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
                    //labelText: arr.last,
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
                width: 300,

                child: Text(

                  date_val,
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
                  controller: dateinput,
                  //editing controller of this TextField
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Enter Date", //label text of field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  readOnly: true,
                  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        dateinput.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
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

                            arr.first=fuelconsumption.text;
                            arr.last=amount.text;
                            setState(() {
                              sending = true;
                            });
                            validate();
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
  void validate()
  {
    int x =0;
    if(val.isNotNull(fuelconsumption.text)) {
      x=1;
      fuelconsumption_val = "Fuel consumption cannot be empty";
    }
    if (!val.isValidfloat(fuelconsumption.text)) {
      x=1;
      fuelconsumption_val = "Enter valid value!!!";
    }
    else fuelconsumption_val="";

    if(val.isNotNull(amount.text)) {
      x=1;
      amount_val = "Amount cannot be empty";
    }
    if (!val.isValidfloat(amount.text)) {
      x=1;
      amount_val = "Enter valid value!!!";
    }
    else amount_val="";
    if(!val.isNotNull(dateinput.text)) {
      x=1;
      date_val = "Date cannot be empty";
    }
    else
    {
      x=0;
      date_val="";
    }
    if(x==0){
      sendData();
    }
  }
}