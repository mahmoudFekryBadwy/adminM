import 'package:adminm/maduls/home_screen.dart';
import 'package:adminm/maduls/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class AuthServer{
  handleAuthState(){
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context,snapshot){
          if(snapshot.hasData){
            return  const HomeScreen();
          }else {
            return   LoginScreen();
          }
        }
    );
  }
}