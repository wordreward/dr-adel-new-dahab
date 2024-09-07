import 'package:adelnewversion/core/core.dart';
import 'package:adelnewversion/core/theme/fonts.dart';
import 'package:flutter/material.dart';

class Appbar extends StatelessWidget{
  Appbar({
    Key? key,
    required this.title,
    this.fontSize,
    required this.showBackButton,
    required this.topPadding,
  }) : super(key: key);

  final String? title;
  final double? fontSize;
  final bool showBackButton;
  final bool topPadding;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(top: topPadding?kToolbarHeight:0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(showBackButton!) InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.only(top: 2,bottom: 2,right: 15,left: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primaryComponentColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back,color: secondTextColor,size: 25,),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width-120,
            child: Text(
                textAlign: TextAlign.center,
                title!.toUpperCase(),
                style: Fonts().titleFont(fontSize ?? 34, FontWeight.bold)
            ),
          ),
        ],
      ),
    );
  }
}