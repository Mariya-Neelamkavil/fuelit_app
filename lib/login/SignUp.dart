import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fuelit_app/login//LoginScreen.dart';
import 'package:http/http.dart' as http;

TextEditingController namectl=TextEditingController();


class SignUp extends StatelessWidget{
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

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child:
//             Container(
//               height: 200,
//               width: 100,
//               color:  Colors.yellow,
//         ),
//       ),
//     );
//   }


class WriteSQLdataState extends State<WriteSQLdata>{

  TextEditingController namectl = TextEditingController();
  // TextEditingController addressctl = TextEditingController();
  // Textl̥EditingController classctl = TextEditingController();
  // TextEditingController rollnoctl = TextEditingController();
  //text controller for TextField

  late bool error, sending, success;
  late String msg;

  String phpurl = "http://192.168.0.101/test/write.php";
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
          "name": namectl.text,
          // "address": addressctl.text,
          // "class": classctl.text,
          // "rollno": rollnoctl.text,
      }); //sending post request with header data

     if (res.statusCode == 200) {
       print(res.body); //print raw response on console
       var data = json.decode(res.body); //decoding json to array
       if(data["error"]){
          setState(() { //refresh the UI when error is recieved from server
             sending = false;
             error = true;
             msg = data["message"]; //error message from server
          });
       }else{
         
         namectl.text = "";
        //  addressctl.text = "";
        //  classctl.text = "";
        //  rollnoctl.text = "";
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
            msg = "Error during sendign data.";
            sending = false;
            //mark error and refresh UI with setState
        });
    }
  }




 @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
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
                      Text('Sign Up',
                        style: TextStyle(
                            fontSize: 25.0,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: namectl,
                  decoration: InputDecoration(
                    hintText: 'Full name',
                    suffixIcon: Icon(Icons.account_circle),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    suffixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Mobile no',
                    suffixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Username',
                    suffixIcon: Icon(Icons.account_circle_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              SizedBox(
                width: 300,
                child: TextField(
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
              SizedBox(height: 20.0,),
              SizedBox(
                width: 300,
                child: TextField(
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
              SizedBox(height: 30.0,),
              SizedBox(
                width: 300,
                child:  Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        child: Text('SignUp'),
                        style: ElevatedButton.styleFrom(backgroundColor: Color(0xffEE7B23)),
                        onPressed: (){ //if button is pressed, setstate sending = true, so that we can show "sending..."
                          setState(() {
                             sending = true;
                          });
                          sendData();
                        
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height:20.0),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                },
                child: Text.rich(
                  TextSpan(
                      text: 'Already have an account ',
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                              color: Color(0xff1F618D)
                          ),
                        ),
                      ]
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

// Future getData() async{
  //   var url = 'https://192.168.93.39/write_new.php';
  //   http.Response response = await http.get(url);
  //   var data = jsonDecode(response.body);
  //   print(data.toString());
  // }

// class Second extends StatefulWidget {
//   @override
//   _SecondState createState() => _SecondState();
// }
//
// class _SecondState extends State<Second> {
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery
//         .of(context)
//         .size
//         .width;
//     double height = MediaQuery
//         .of(context)
//         .size
//         .height;
//     return Scaffold(
//       body: Container(
//         height: height,
//         width: width,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: width,
//                 height: height * 0.45,
//                 child: Image.asset('assets/play.png', fit: BoxFit.fill,),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text('Signup', style: TextStyle(
//                         fontSize: 25.0, fontWeight: FontWeight.bold),),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 30.0,),
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Email',
//                   suffixIcon: Icon(Icons.email),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.0,),
//               TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   hintText: 'Password',
//                   suffixIcon: Icon(Icons.visibility_off),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30.0,),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Forget password?', style: TextStyle(fontSize: 12.0),),
//                     ElevatedButton(
//                       child: Text('Signup'),
//                       style: ElevatedButton.styleFrom(backgroundColor: Color(0xffEE7B23)),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => LoginScreen()));
//                 },
//                 child: Text.rich(
//                   TextSpan(
//                       text: 'Already have an account',
//                       children: [
//                         TextSpan(
//                           text: 'Signin',
//                           style: TextStyle(
//                               color: Color(0xffEE7B23)
//                           ),
//                         ),
//                       ]
//                   ),
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class UserAdd extends StatelessWidget
// {
// bool valname=false;
//   String phpurl="http://192.168.93.39/write_new.php";
//   Future sendData() async
//   {
//     String name = namectl.text;
//     var Data={ 'name' : name};
//     var res=await http.post(Uri.parse(phpurl),body: {
//       "name": namectl.text.toString(),
//     };
//     var message = jsonDecode(res.body);
//     if (message == "true") {
//       print("Successful " + message);
//     } else {
//       print("Error: " + message);
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold();
//   }
// }