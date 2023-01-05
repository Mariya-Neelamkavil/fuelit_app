import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fuelit_app/userhome/UserHomePage.dart';
import 'ForgetPassword.dart';
import 'package:fuelit_app/login/SignUp.dart';
import 'package:http/http.dart' as http;
import 'package:fuelit_app/adminhome/AdminHomePage.dart';

var ip = "192.168.111.199";

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  // text controller for TextField

  late bool error, sending, success, showprogress;
  late String msg, errormsg;


  void initState() {

    errormsg = "";
    error = false;
    showprogress = false;

    super.initState();
  }


  startLogin() async {
    String phpurl = "http://$ip/fuelit/Login.php"; // url


    var response = await http.post(Uri.parse(phpurl), body: {
      'dbemail': email.text, //get the username text
      'dbpass': pass.text //get password text
    });

    if (response.statusCode == 200) {

      print(json.decode(response.body));
      var jsondata = json.decode(response.body);
      if (jsondata["error"]) {
        setState(() {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = jsondata["message"];
        });
      } else {
        if (jsondata["success"]) {
          setState(() {
            error = false;
            showprogress = false;
          });
          //save the data returned from server
          //and navigate to home page
          //String uid = jsondata["uid"];
          String name = jsondata["name"];
          print(name);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserHomePage()),
          );
          //user shared preference to save data
        } else {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = "Something went wrong.";
        }
      }
    } else {
      print("Status code !=200");
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
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
                  //width: 300,
                  child: Container(
                    // width: width,
                    // height: height * 0.45,
                    child: Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.fill,
                    ),
                  )),
              // SizedBox(
              //   height: 8.0,
              // ),
              SizedBox(
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          errormsg,
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 8.0,
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
                  )),
              SizedBox(
                height: 20.0,
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
                  )),
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPassword()));
                        },
                        child: Text.rich(
                          TextSpan(
                            text: 'Forgot Password',
                            style: TextStyle(
                              color: Color(0xff1F618D),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffDC7633)),
                        onPressed: () {
                          //if button is pressed, setstate sending = true, so that we can show "sending..."
                          setState(() {
                            sending = true;
                          });
                          // startLogin();
                          if(adminLogin())
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AdminHomePage()),
                              );
                            }
                          else
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => UserHomePage()),
                              );
                            }
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
                  TextSpan(text: 'Don\'t have an account ?? ', children: [
                    TextSpan(
                      text: 'Signup',
                      style: TextStyle(
                        color: Color(0xff1F618D),
                      ),
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

  bool adminLogin() {
    print(email.text);
    if(email.text=="admin" && pass.text=="1234")
    {
      return true;
    }
    else
    {
      return false;
    }
  }
}
