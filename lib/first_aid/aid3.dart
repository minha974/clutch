import 'package:flutter/material.dart';
import 'package:flutter_application_1/MainPage/tool.dart';


class AidTile extends StatelessWidget {
  Tool aid;
  void Function()? onTap;
  AidTile({super.key, required this.aid, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left:25),
      width:280,
      decoration:BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        Image.asset(aid.imagePath, width: 200,),
        Text(aid.description, style: TextStyle(color: Colors.grey),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //tool name
                  Text(aid.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                  //price
                  Text(' \$ '+aid.price, style: TextStyle(color: Colors.grey),),
                  //plus button
                ],
              ),
              GestureDetector(onTap: onTap,child: Container(child: Icon(Icons.add, color: Color(0xFF86ab0c), size: 30,))),
            ],
          ),
        )
      ],

      ),
    );
  }
}