import 'package:flutter/material.dart';
import '../../Services/Methods/ShowBtmAlert.dart';
import '../../Services/Models/CardModel.dart';
import '../Widgets/CustomAppBar.dart';
import '../Widgets/HomeViewWidget.dart';
class HomeViewPage extends StatelessWidget {
  const HomeViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    const CustomAppBar(isMain: true, title: 'الصفحة الرئيسية',),
                    const Spacer(),
                    IconButton(onPressed: (){
                      showBtmAlert(context, 'لم يتم إنشاء حساب',600);
                    }, icon: Icon(Icons.account_circle_sharp,color:Colors.black87.withOpacity(0.8),)),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 220,
                  height: 1.5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(16)
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: height*0.8,
                  child: ListView.builder(
                      itemCount: cardsData.length,
                      itemBuilder: (builder , index){
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: (){
                            index == 4 ?
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> cardsData[index].screen))
                                : Navigator.push(context, MaterialPageRoute(builder: (context)=> cardsData[index].screen));
                          },
                          child: HomeWidget(color: cardsData[index].color, title: cardsData[index].title, icon: cardsData[index].image,)),
                    );
                  }),
                )
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
