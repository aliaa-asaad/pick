import 'package:flutter/material.dart';
import 'package:pick_up/utilities/media_quary.dart';

class OrderType extends StatefulWidget {
  const OrderType({super.key});

  @override
  State<OrderType> createState() => _OrderTypeState();
}

class _OrderTypeState extends State<OrderType> {
  int currentIndex = -1;
  List<String> content = [
    'أثاث منزلي',
    'اجهزة كهربائية',
    'مواشي وحيوانات',
    'مواد بناء وديكور',
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQueryHelper.height * .18,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 8,),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio:2.5,
          crossAxisSpacing: MediaQueryHelper.width * .05,
          mainAxisSpacing:
              MediaQueryHelper.height * .01, /*  mainAxisExtent: 500 */
        ),
        itemCount: content.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() {
              currentIndex = index;
            });
          },
          child: Container(
            height: MediaQueryHelper.height * .1,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: currentIndex == index ? Colors.green : Colors.grey,
                width: 1.5
              ),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Text(content[index]),
                Spacer(),
                Icon(
                  Icons.check_circle,
                  color: currentIndex == index ? Colors.green : Colors.grey,
                )
              ],
            ),
          ),
        ),
      ),
    ) 
        ;
  }
}
