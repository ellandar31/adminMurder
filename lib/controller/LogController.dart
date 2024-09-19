
import 'package:admin_app/utilitaires/auth_google_widget.dart';
import 'package:admin_app/utilitaires/authentification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LogController extends StatefulWidget {
  @override
  State<LogController> createState() => _LogControllerState();
}

class _LogControllerState extends State<LogController> {


  late String _addressMail;
  late String _password;

  @override
  Widget build(Object context) {
    Authentification authFBHandler = new Authentification();
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8.0),
            child: Card(
              elevation: 4.0,
              child: Container(
                margin: EdgeInsets.only(right: 5,left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      decoration: InputDecoration(hintText: "adresse email"),
                      onChanged: (string){
                        _addressMail = string;
                      }

                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "mot de passe"),
                      obscureText: true,
                      onChanged: (string){
                        setState(() {                          
                        _password = string;
                        });
                      }

                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: (){
              authFBHandler.signInEmailPassword(context,_addressMail,_password);
            },
            child: Text( "Connection"),
          ),
          AuthGoogleWidget(),
          ElevatedButton(
            onPressed: (){
              if(kIsWeb) {
                authFBHandler.signInWithGoogle();
              } else {
                authFBHandler.signInWithGoogleMobile();
              }
            },
            child: Text( "Google"),
          ),
        ],
      ),
    );

    
  }
  
}