import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fuelit_app/login//SignUp.dart';
import 'ValidateOTP.dart';
import 'package:http/http.dart' as http;

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

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

  TextEditingController email = TextEditingController();
  TextEditingController mobile  = TextEditingController();
  // text controller for TextField

  late bool error, sending, success;
  late String msg;

  String phpurl = "http://192.168.174.25/ForgotPassword.php";
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

     var res = await http.post(Uri.parse(phpurl), body: { 
          "dbemail": email.text,
          "dbmobile": mobile.text,
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
         
         email.text = "";
         email.text = "";
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
                width: 400,
                child: Container(
                  width: width,
                  height: height * 0.45,
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Forgot Password',
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold),
                        // textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Email id',
                    suffixIcon: Icon(Icons.email),
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
                  controller: mobile,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Mobile no',
                    suffixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text('Next'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffEE7B23)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ValidateOTP()));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Text.rich(
                  TextSpan(text: 'Don\'t have an account ', children: [
                    TextSpan(
                      text: 'Signup',
                      style: TextStyle(color: Color(0xff1F618D)),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


