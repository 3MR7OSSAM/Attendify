import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Services/Methods/ShowBtmAlert.dart';

class StudentInfoWidget extends StatefulWidget {
   const StudentInfoWidget({Key? key, required this.name, required this.code, required this.phone}) : super(key: key);

  final String name;
  final String code;
  final String phone;

   

  @override
  State<StudentInfoWidget> createState() => _StudentInfoWidgetState();
}
bool showNumber = false;
class _StudentInfoWidgetState extends State<StudentInfoWidget> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 3),
      child: Card(
        shadowColor: Colors.black,
        elevation: 3,
        child: Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.code,style: const TextStyle(color: Colors.black87,fontSize: 16)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 10,
                          width: 1,
                          decoration: const BoxDecoration(
                              color: Colors.black
                          ),
                        ),
                      ),
                      Text(widget.name,style: const TextStyle(color: Colors.black87,fontSize: 16),),
                      const Spacer(),
                      InkWell(
                          onTap: (){
                            setState(() {
                              showNumber= !showNumber;
                            });
                          },
                          child:  const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(Icons.call,size: 16,color:Colors.black87,),
                          ))
                    ],
                  ),
                ),
                showNumber ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        width: 250,
                        height: 1,
                        decoration: const BoxDecoration(
                            color: Colors.black87
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('رقم الهاتف : ${widget.phone} ',style:  TextStyle(color: Colors.deepOrange.shade400,fontSize: 16,),),
                        ),
                        const Spacer(),
                        TextButton(onPressed: ()async{
                          await Clipboard.setData(ClipboardData(text: widget.phone));
                          context.mounted  ? showBtmAlert(context, 'تم النسخ',600):null;
                        }, child:  Text('نسخ',style: TextStyle(color: Colors.deepOrange.shade400),))
                      ],
                    ),
                  ],
                ):Container()
              ],
            ),
          ],
        )
      ),
    );
  }
}
