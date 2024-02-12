import 'package:flutter/material.dart';
void showBtmAlert(context , String message , int duration ){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration:  Duration(milliseconds: duration),
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Material(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.red
              )
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child:  Center(child: Text(message,style: const TextStyle(color: Colors.red,fontSize: 16,),textAlign: TextAlign.center,),

            ),
          ),
        ),
      ));
}