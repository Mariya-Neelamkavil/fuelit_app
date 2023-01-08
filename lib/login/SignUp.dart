import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fuelit_app/Validation.dart';
import 'package:fuelit_app/login//LoginScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'LoginScreen.dart' as ls;
import 'dart:async';



class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red, //primary color for theme
        ),
        home: WriteSQLdata() //set the class here
        );
  }
}

////////////////////////////////////////////////
///////////////////////////////////////////////

class WriteSQLdata extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WriteSQLdataState();
  }
}

class WriteSQLdataState extends State<WriteSQLdata> {

  Validation val = new Validation();
  TextEditingController fname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController uname = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController pass_conf = TextEditingController();
  String email_val = "";
  String pass_val = "";
  String mobile_val = "";
  String uname_val = "";
  String fname_val = "";
  String pass_conf_val = "";

  // text controller for TextField

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
    print("\n\nsendData::::");

    // String internal =  await GetIp.ipAddress;
    // final String ipv4 = await FlutterIp.internalIP;
    String phpurl = "http://${ls.ip}/fuelit/SignUp.php";
    print(phpurl);
    var res = await http.post(Uri.parse(phpurl), body: {
      "dbfname": fname.text,
      "dbemail": email.text,
      "dbmobile": mobile.text,
      "dbuname": uname.text,
      "dbpass": pass.text,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print("RES.BODY:::${res.body}"); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {
        setState(() {
          //refresh the UI when error is received from server
          sending = false;
          error = true;
          msg = data["message"]; //error message from server
        });
      } else {
        fname.text = "";
        email.text = "";
        mobile.text = "";
        uname.text = "";
        pass.text = "";
        //after write success, make fields empty

        setState(() {
          sending = false;
          success = true; //mark success and refresh UI with setState
        });
      }
    } else {
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
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Sign Up',
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
                  fname_val,
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
                  controller: fname,
                  decoration: InputDecoration(
                    hintText: 'Full name',
                    suffixIcon: Icon(Icons.account_circle),
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
                  email_val,
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
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    suffixIcon: Icon(Icons.email),
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
                  mobile_val,
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
                  controller: mobile,
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
                height: 20.0,
                width: 300,
                child: Text(
                  uname_val,
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
                  controller: uname,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    suffixIcon: Icon(Icons.account_circle_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 700,
                child: Text(
                  pass_val,
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
                  controller: pass,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: Icon(Icons.visibility_off),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 500,
                child: Text(
                  pass_conf_val,
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
                  controller: pass_conf,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    suffixIcon: Icon(Icons.visibility_off),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        child: Text('SignUp'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffEE7B23)),
                        onPressed: () {

                          //if button is pressed, setstate sending = true, so that we can show "sending..."
                          setState(() {
                            sending = true;
                          });
                          validate();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => LoginScreen()),
                          // );
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
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text.rich(
                  TextSpan(text: 'Already have an account ', children: [
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(color: Color(0xff1F618D)),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    // ignore: dead_code
    );
  }
  void validate()
  {
    int x =0;
    if (!val.isValidEmail(email.text)) {
      x=1;
      email_val = "Enter valid Email ID!!!";
    }
    else email_val="";

    if (!val.isValidPassword(pass.text)) {
      x=1;
      pass_val = "Password must be 8 characters with letters, numbers and symbols";
    }
    else pass_val="";

    if (!val.isValidPhone(mobile.text)) {
      x=1;
      mobile_val = "Enter valid Phone Number!!!";
    }
    else mobile_val="";
    if (val.isNotNull(pass_conf.text)) {
      x=1;
      pass_conf_val = "Confirm Password field must not be empty!!!";
    }
    else pass_conf_val="";

    if (uname.text.isEmpty) {
      x=1;
      uname_val = "Username field must not be empty!!!";
    }
    else uname_val="";

    if (fname.text.isEmpty) {
      x=1;
      fname_val = "Full name must not be empty!!!";
    }
    else fname_val="";

    if(pass.text!=pass_conf.text) {
      x = 1;
      pass_conf_val = "Password and confirm password should be same";
    }
    if(x==0){
      sendData();
    }
  }
}



