import 'package:flutter/material.dart';

class ColorSpecifier extends StatelessWidget {
  const ColorSpecifier({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue.shade400
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('حصة',style: TextStyle(fontSize: 18),),
          ),
          const SizedBox(width: 20,),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.deepOrange.shade400
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('إمتحان',style: TextStyle(fontSize: 18)),
          ),


        ],
      ),
    );
  }
}
