import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/features/order/presentation/widgets/confirm_content.dart';
import 'package:pick_up/utilities/media_quary.dart';

class OrderConfirmScreen extends StatelessWidget {
  const OrderConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> content = [
      {'title': 'نوع الشاحنة', 'content': 'نوع الشاحنة', 'isTruck': true},
      {'title': 'نوع الشاحنة', 'content': 'نوع الشاحنة', 'isTruck': false},
      {'title': 'نوع الشحنة', 'content': 'نوع الشاحنة', 'isTruck': false},
      {'title': 'مواصفات شحنتك', 'content': 'نوع الشاحنة', 'isTruck': false},
      {
        'title': 'خدمات التحميل والتنزيل',
        'content': 'نوع الشاحنة',
        'isTruck': false
      },
      {'title': 'المصعد الكهربائي', 'content': 'نوع الشاحنة', 'isTruck': false},
      {'title': 'عامل إضافي', 'content': 'نوع الشاحنة', 'isTruck': false},
    ];
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(16.0.r),
      child: Stack(
        children: [
          SizedBox(
            height: MediaQueryHelper.height,
            width: MediaQueryHelper.width,
          ),
          Container(
            margin: EdgeInsets.only(
                left: MediaQueryHelper.width * .015,
                top: MediaQueryHelper.height * .02),
            height: MediaQueryHelper.height,
            width: MediaQueryHelper.width * .005,
            color: Colors.grey,
          ),
          Column(
            children: List.generate(
              content.length,
              (index) => ConfirmContent(
                  title: content[index]['title'],
                  content: content[index]['content'],
                  isTruck: content[index]['isTruck']),
            ),
          )
          /* SizedBox(
            height: MediaQueryHelper.height,
            child: ListView.builder(
              itemBuilder: (context, index) => 
              itemCount: content.length,
            ),
          ), */
          /* Column(
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
                      'نوع الشاحنة',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
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
                      // child: Icon(Icons.check),
                    ),
                    SizedBox(
                      width: MediaQueryHelper.width * .03,
                    ),
                    Expanded(
                      child: Container(
                        //width: MediaQueryHelper.width ,
                        padding: EdgeInsets.all(8.0.r),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          'نوع الشاحنة',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
         */
        ],
      ),
    );
  }
}
