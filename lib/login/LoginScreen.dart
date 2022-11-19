import 'dart:convert';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'ForgetPassword.dart';
import 'package:fuelit_app/login/SignUp.dart';
import 'package:fuelit_app/userhome/homepage.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
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
  TextEditingController pass  = TextEditingController();
  // text controller for TextField

  late bool error, sending, success, showprogress;
  late String msg, errormsg;
  // late String username, password;



  // @override
  // void initState() {
  //     error = false;
  //     sending = false;
  //     success = false;
  //     msg = "";
  //     super.initState();
  // }

  void initState() {
    //  username= "";
    //  password= "";
     errormsg = "";
     error = false;
     showprogress = false;

     //_username.text = "defaulttext";
     //_password.text = "defaultpassword";
    super.initState();
  }

  
// Future<void> sendData() async {
    
    
//   final ipv4 = await Ipify.ipv4();
//   String phpurl = "http://"+ipv4+"/ManualBillEntry.php";

//      var res = await http.post(Uri.parse(phpurl), body: { 
//           "dbemail": email.text,
//           "dbpass": pass.text,
//       }); //sending post request with header data

//      if (res.statusCode == 200) {
//        print("RES.BODY:::" + res.body); //print raw response on console
//        var data = json.decode(res.body); //decoding json to array
//        if(data["error"]){
//           setState(() { //refresh the UI when error is received from server
//              sending = false;
//              error = true;
//              msg = data["message"]; //error message from server
//           });
//        }else{
         
//          email.text = "";
//          pass.text = "";
//          //after write success, make fields empty

//           setState(() {
//              sending = false;
//              success = true; //mark success and refresh UI with setState
//           });
//        }
       
//     }else{
//        //there is error
//         setState(() {
//             error = true;
//             msg = "Error during sending data.";
//             sending = false;
//             //mark error and refresh UI with setState
//         });
//     }
//   }


  startLogin() async {
    
    
  final ipv4 = await Ipify.ipv4();
  String phpurl = "http://"+ipv4+"/ManualBillEntry.php"; // url
  
     print(email);

     var response = await http.post(Uri.parse(phpurl), body: {
        'dbemail': email.text, //get the username text
        'dbpass': pass.text  //get password text
     });
       
     if(response.statusCode == 200){
         var jsondata = json.decode(response.body);
         if(jsondata["error"]){
             setState(() {
                 showprogress = false; //don't show progress indicator
                 error = true;
                 errormsg = jsondata["message"];
             });
         }else{
            if(jsondata["success"]){
               setState(() {
                  error = false;
                  showprogress = false;
               });
               //save the data returned from server
               //and navigate to home page
               String uid = jsondata["uid"];
               String name = jsondata["Name"];
               print(name);
               //user shared preference to save data
            }else{
               showprogress = false; //don't show progress indicator
               error = true;
               errormsg = "Something went wrong.";
            }  
         }
     }else{
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
                  width: 400,
                  child: Container(
                    width: width,
                    height: height * 0.45,
                    child: Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.fill,
                    ),
                  )),
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold),
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
                        onPressed: () { //if button is pressed, setstate sending = true, so that we can show "sending..."
                          setState(() {
                             sending = true;
                          });
                          startLogin();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => homepage()),
                          );
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
}
