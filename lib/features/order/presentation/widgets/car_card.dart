import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/features/order/data/view_model/bloc/order_bloc.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';

class CarCard extends StatefulWidget {
  const CarCard({super.key});

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQueryHelper.height * .239,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: OrderBloc.instance.carCardData.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() {
              OrderBloc.instance.carIndex = index;
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
                  color: OrderBloc.instance.carIndex == index
                      ? Colors.green
                      : Colors.transparent,
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
                OrderBloc.instance.carCardData[index]['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Image.asset(
                OrderBloc.instance.carCardData[index]['image'],
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
                    OrderBloc.instance.carCardData[index]['length'],
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
                    OrderBloc.instance.carCardData[index]['weight'],
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_circle,
                    color: OrderBloc.instance.carIndex == index
                        ? Colors.green
                        : Colors.grey,
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
