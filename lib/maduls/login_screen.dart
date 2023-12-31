
import 'package:adminm/maduls/home_screen.dart';
import 'package:adminm/services/alert_login.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {
  var mypassword, myemail;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  signIn() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showLoading(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: myemail, password: mypassword);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: const Text("No user found for that email"))
              .show();
        } else if (e.code == 'wrong-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: const Text("Wrong password provided for that user"))
              .show();
        }
      }
    } else {
      print("Not Vaild");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/logo.jpeg',),
                      fit: BoxFit.cover
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Center(child: Image.asset("images/cs.png")),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                        key: formstate,
                        child: Column(
                          children: [
                            TextFormField(
                              onSaved: (val) {
                                myemail = val;
                              },
                              validator: (val) {
                                if (val!.length > 100) {
                                  return "Email can't to be larger than 100 letter";
                                }
                                if (val.length < 2) {
                                  return "Email can't to be less than 2 letter";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1))),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              onSaved: (val) {
                                mypassword = val;
                              },
                              validator: (val) {
                                if (val!.length > 100) {
                                  return "Password can't to be larger than 100 letter";
                                }
                                if (val.length < 4) {
                                  return "Password can't to be less than 4 letter";
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.person),
                                  hintText: "password",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1))),
                            ),
                            SizedBox(height: 20,),
                            Container(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    var user = await signIn();
                                    if (user != null) {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                        return const HomeScreen();
                                      }));
                                    }
                                  },
                                  child: Text(
                                    "Sign in",
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                )
                            )
                          ],
                        )),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}