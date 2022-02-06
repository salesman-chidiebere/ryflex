import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ryflex/AllWidgets/progressDialog.dart';

class LoginSignUp extends StatefulWidget {
  const LoginSignUp({Key key}) : super(key: key);

  @override
  _LoginSignUpState createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {

  final userRef = FirebaseFirestore.instance.collection("users");


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool signUpPage = true;
  String btnText = "SignUp";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: navigationOption(),
              ),
              SizedBox(height: 30,),
              logoText(),
              SizedBox(height: 20,),
              Visibility(
                visible: signUpPage,
                  child: Column(
                    children: [
                      userNameTextField(),
                      phoneTextField(),
                    ],
                  ),
              ),

              emailTextField(),
              passwordTextField(),
              SizedBox(height: 20,),
              signInSignUp(),
            ],
          ),
        ),
      ),
    );
  }

  Widget navigationOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              signUpPage =true;
              btnText = "SignUp";
            });
          },
          child: Text("SignUp", style: TextStyle(color: Colors.grey,
            fontSize: 25),),
        ),
        InkWell(
          onTap: () {
            setState(() {
              signUpPage = false;
              btnText = "Login";
            });


          },
          child: Text("Login", style: TextStyle(color: Colors.grey,
              fontSize: 25),),
        ),
      ],
    );
  }

  Widget logoText(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/car_ios.png',
          height: 100,
          width: 100,
          ),
        SizedBox(width: 10,),
        Text("Ryflex", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700,
            color: Colors.red),)
      ],
    );
  }

  Widget userNameTextField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        alignment: Alignment.centerLeft,
        height: 60,
        decoration: kBoxDecor,
        child: TextFormField(
          controller: userNameController,
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.red, fontFamily: 'Opensans'),
          decoration:InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(Icons.account_circle, color: Colors.red,),
            hintText: "Enter your username",
          ),
        ),
      ),
    );
  }

  Widget phoneTextField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        alignment: Alignment.centerLeft,
        height: 60,
        decoration: kBoxDecor,
        child: TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          style: TextStyle(color: Colors.red, fontFamily: 'Opensans'),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(Icons.phone, color: Colors.red,),
            hintText: "Enter your phone number",
          ),
        ),
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        alignment: Alignment.centerLeft,
        height: 60,
        decoration: kBoxDecor,
        child: TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Colors.red, fontFamily: 'Opensans'),
          decoration:InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(Icons.email, color: Colors.red,),
            hintText: "Enter you Email",
          ),
        ),
      ),
    );
  }

  Widget passwordTextField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        alignment: Alignment.centerLeft,
        height: 60,
        decoration: kBoxDecor,
        child: TextFormField(
          controller: passwordController,
          keyboardType: TextInputType.text,
          obscureText: true,
          style: TextStyle(color: Colors.red, fontFamily: 'Opensans'),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(Icons.lock, color: Colors.red,),
            hintText: "Enter you password",
          ),
        ),
      ),
    );
  }

  Widget signInSignUp(){
    return ElevatedButton(
        onPressed: (){
          (signUpPage)
              ? _register()
              : _login();
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.red,
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(btnText, style: TextStyle(fontSize: 24),),
        ));
  }

  final FirebaseAuth  _auth = FirebaseAuth.instance;

  void _register() async {

    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return ProgressDialog(message: "Registering, please wait...");
        });

    final User user = (
     await _auth.createUserWithEmailAndPassword(
         email: emailController.text.trim(),
         password: passwordController.text.trim())
         .catchError((errMsg){
           print("Our Error message: $errMsg");
           Navigator.pop(context);
           displayToastMsg(context, "$errMsg", "Error");
     })
    ).user;
    if(user != null){

      userRef.doc(user.uid).set({
        "name" : userNameController.text.trim(),
        "email" : emailController.text.trim(),
        "phone" : phoneController.text.trim()
      }).then(
         (value) {
           Navigator.pop(context);
           displayToastMsg(context, "Congratulations, account created", "Success");
         }).catchError((onError){
        Navigator.pop(context);
        displayToastMsg(context, "$onError", "Error");
      });
      

      print("User created successly");
      setState(() {
        signUpPage = false;
        btnText = "Login";
      });
    }else {
      print("User account creation failed");
      Navigator.pop(context);
      displayToastMsg(context, "Account creation failed...", "Failed");
    }
  }

  void _login() async {

    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return ProgressDialog(message: "Verifying Login, please wait...");
        });

    final User user = (
        await _auth.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
            .catchError((errMsg) {
          print("Our Error message: $errMsg");
          Navigator.pop(context);
          displayToastMsg(context, "$errMsg", "Error");
        })
    ).user;
    if (user != null) {
      print("Login Successful");
      Navigator.pop(context);
    } else {
      print("Login failed");
      Navigator.pop(context);
      displayToastMsg(context, "User login failed", "Failed");
    }
  }



  final kBoxDecor = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      )
    ]
  );

}

/*displayToastMsg(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}*/

Future<void> displayToastMsg(BuildContext context, String msg, String title1) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("$title1"),
        content: Text(msg,),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


