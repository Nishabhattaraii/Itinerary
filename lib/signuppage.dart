import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itinerary/loginpage.dart';
import 'package:itinerary/uihelper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  
  SignUp(String email, String password)async{
    if(email=="" && password==""){
      UiHelper.CustomAlertBox(context,"Enter Required Fields");
    }
    else{
      UserCredential? usercredential;
      try{
        usercredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginPage()));
          return null;
        } );
      }
      on FirebaseAuthException catch(ex){
        return UiHelper.CustomAlertBox(context, ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Page"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center ,
        children: [
        UiHelper.CustomTextField(emailController,"Email", Icons.mail, false),
        UiHelper.CustomTextField(passwordController, "Password", Icons.password, true),
        SizedBox(height: 30),
        UiHelper.CustomButton(() {
          SignUp(emailController.text.toString(), passwordController.text.toString());
         }, "Sign Up")
      ]),
    );
  }
}