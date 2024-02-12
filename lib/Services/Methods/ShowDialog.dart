import 'package:flutter/material.dart';

Future<void> showLogoutDialog(BuildContext context,String title,String message,Function? onTap) async {
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text('تراجع',style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 14
              )
              ),),
              TextButton(onPressed: (){
                if(Navigator.canPop(context)){
                  Navigator.pop(context);
                }
              }, child: InkWell(
                onTap: (){
                  onTap!();
                },
                child: const Text('حذف',style: TextStyle(
                    color: Colors.red,
                    fontSize: 14
                )
                ),
              ),),

            ],
            content: Text(message,style: TextStyle(fontSize: 18),),
        //    title:  Text(title),
        );

      });
}
