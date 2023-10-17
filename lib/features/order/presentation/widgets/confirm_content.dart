import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class ConfirmContent extends StatelessWidget {
  final String title;
  final String? content;
  
  final bool isTruck;
  const ConfirmContent(
      {super.key,
      required this.title,
      this.content,
      
      this.isTruck = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.0.r),
          child: Row(
            children: [
              CircleAvatar(
                radius: 6.r,
                backgroundColor: Theme.of(context).colorScheme.primary,
                // child: Icon(Icons.check),
              ),
              SizedBox(
                width: MediaQueryHelper.width * .03,
              ),
              Text(
                title,
                 style: TextStyleHelper.subtitle20.copyWith(
                   color: Theme.of(context).colorScheme.primary
                 ),
               
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 8.0.r),
          child: Row(
            children: [
              CircleAvatar(
                radius: 6.r,
                backgroundColor: Colors.grey,
                
              ),
              SizedBox(
                width: MediaQueryHelper.width * .03,
              ),
              Expanded(
                child: Container(
                  
                  padding: EdgeInsets.all(8.0.r),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: isTruck
                      ? Container(
                          width: MediaQueryHelper.width,
                          child: Text('بيك اب'),)
                      : Text(
                          content!,
                        ),
                ),
              )
            ],
          ),
        ),
        
      ],
    );
  }
}
