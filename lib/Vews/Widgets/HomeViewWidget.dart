import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key, required this.color, required this.title, required this.icon}) : super(key: key);
  final Color color;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return  Container(

      width: double.infinity,
      height: 80,
     
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(icon,width: 30,color: Colors.black,),
              ),
              Container(
                height: 30,
                width: 1,
                decoration: const BoxDecoration(
                  color: Colors.black
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(title,style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
