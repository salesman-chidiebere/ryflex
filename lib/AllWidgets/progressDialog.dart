import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget{

  String message;
  ProgressDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black54,
      child: Container(
        margin: EdgeInsets.all(15.0),
        width: MediaQuery.of(context).size.width / 1.2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              SizedBox(width: 6.0,),
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation
              <Color>(Colors.red),),
              SizedBox(width: 10,),
              Text(
                message, style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }

}