
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class success extends StatefulWidget {
  const success({super.key});

  @override
  State<success> createState() => _successState();
}

class _successState extends State<success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Success SignUp",style: TextStyle(fontSize: 20.0),),
          ),
          SizedBox(height: 10.0,),
          MaterialButton(
            textColor: Colors.white,
            color: Colors.blue,
            minWidth: 100.0,
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
            },
          child: Text("login",style: TextStyle(fontSize: 17.0),),
          )
        ],
      ),
    );
  }
}