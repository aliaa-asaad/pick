import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';

class ConfirmCarCard extends StatelessWidget {
final String image;
final String title;
final String length;
final String weight;
  const ConfirmCarCard({
    super.key, required this.image, required this.title, required this.length, required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Image.asset(
            image,
            height: MediaQueryHelper.height * .1,
            width: MediaQueryHelper.width * .3,
          ),
          SizedBox(
            width: MediaQueryHelper.width * .03,
          ),
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(title),
              Row(
                children: [
                  SvgPicture.asset(AppImages.length),
                  SizedBox(
                    width: MediaQueryHelper.width * .01,
                  ),
                  Text(
                   length,
                    style: const TextStyle(),
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
                    weight,
                    style: const TextStyle(),
                  ),
                ],
              ),
            ],
          )
        ],
      );
  }
}
