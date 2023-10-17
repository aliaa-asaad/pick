import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';

class CarCard extends StatefulWidget {
  const CarCard({super.key});

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  int currentIndex = -1;
  List<Map<String, dynamic>> carCardData = [
    {
      'image': AppImages.car1,
      'title': 'بيك أب',
      'length': '2 متر - 3 متر',
      'weight': '1 طن',
    },
    {
      'image': AppImages.car2,
      'title': 'دينة شبك',
      'length': '5 متر - 7 متر',
      'weight': '2 طن',
    },
    {
      'image': AppImages.car3,
      'title': 'دينة',
      'length': '2 متر - 3 متر',
      'weight': '2 طن',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQueryHelper.height * .235,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: carCardData.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() {
              currentIndex = index;
            });
          },
          child: Container(
            padding: EdgeInsets.all(8.r),
            width: MediaQueryHelper.width * .5,
            margin: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(
                  color:
                      currentIndex == index ? Colors.green : Colors.transparent,
                  width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                carCardData[index]['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Image.asset(
                carCardData[index]['image'],
                height: MediaQueryHelper.height * .09,
                width: MediaQueryHelper.width,
              ),
              Row(
                children: [
                  SvgPicture.asset(AppImages.length),
                  SizedBox(
                    width: MediaQueryHelper.width * .01,
                  ),
                  Text(
                    carCardData[index]['length'],
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(AppImages.weight),
                  SizedBox(
                    width: MediaQueryHelper.width * .01,
                  ),
                  Text(
                    carCardData[index]['weight'],
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_circle,
                    color: currentIndex == index ? Colors.green : Colors.grey,
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
