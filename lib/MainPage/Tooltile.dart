import 'package:flutter/material.dart';
import 'package:flutter_application_1/MainPage/tool.dart';


class ToolTile extends StatelessWidget {
  Tool tool;
  void Function()? onTap;
  ToolTile({super.key, required this.tool, required this.onTap});

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
        Image.asset(tool.imagePath, width: 200,),
        Text(tool.description, style: TextStyle(color: Colors.grey),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                //tool name
                Text(tool.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                //price
                Text(' \$ '+tool.price, style: TextStyle(color: Colors.grey),),
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