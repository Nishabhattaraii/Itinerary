import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:itinerary/Homepage.dart';
import 'package:itinerary/WelcomePage.dart';
import 'package:itinerary/signuppage.dart';
import 'package:itinerary/uihelper.dart';


class LoginPage extends StatefulWidget{
    const LoginPage({super.key});

    @override
    State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State <LoginPage>{
    TextEditingController emailController=TextEditingController();
    TextEditingController passwordController=TextEditingController();


    login(String email, String password)async{
      if(email=="" && password==""){
        return UiHelper.CustomAlertBox(context, "Enter Required Fields");
      
      }
      else{
        // ignore: non_constant_identifier_names
        UserCredential? usercredential;
        try{
          usercredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
            Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage()));
            return null;
          });
        }
        on FirebaseAuthException catch(ex){
          return UiHelper.CustomAlertBox(context, ex.code.toString());
        }
      }
    }
    
    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(
                title: const Text("Login Page"),
                centerTitle: true,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UiHelper.CustomTextField( emailController,"Email", Icons.mail , false),
                UiHelper.CustomTextField(passwordController,"Password", Icons.password, true),
                const SizedBox(height: 30),
                UiHelper.CustomButton(() {
                  login(emailController.text.toString(), passwordController.text.toString());
                },"Login"),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already Have an Account?",style: TextStyle(fontSize: 16),),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpPage()),);
                    }, child: const Text("Sign Up",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),) )],
                )
            ],
            
             ),
        );
    }
}