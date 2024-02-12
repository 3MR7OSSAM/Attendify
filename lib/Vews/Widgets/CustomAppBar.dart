import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.isMain, required this.title,});
  final bool isMain;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.transparent
      ),
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: isMain ?MainAxisAlignment.start :MainAxisAlignment.center,
          children: [

                Text(title,style:  TextStyle(color:  Colors.black87.withOpacity(0.8),fontSize: 24),),
            isMain ?Container(): const Spacer(),
            isMain ? Container():  InkWell(
                onTap:(){
                  Navigator.pop(context);
                },
                child:  SizedBox(
                    width: 30,
                    height: 30,
                    child: Icon(Icons.arrow_forward_ios_sharp,color:  Colors.black87.withOpacity(0.8),size: 20,))),
          ],
        ),
      ),
    );
  }
}
