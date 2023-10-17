import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/handlers/image_picker_handler.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class OrderImageScreen extends StatefulWidget {
  final Function() onPressed;
  const OrderImageScreen({super.key, required this.onPressed});

  @override
  State<OrderImageScreen> createState() => _OrderImageScreenState();
}

class _OrderImageScreenState extends State<OrderImageScreen> {
  File? picker;
  List<File> imageList = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(24.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
               onTap: () async {
                        var image = await ImagePickerHandler()
                            .getImage(ImageSource.gallery);
                        setState(() {
                          imageList.add(image);
                        });
                      },
              child: Container(
                //alignment: Alignment.center,
                height: MediaQueryHelper.height * 0.25,
                width: MediaQueryHelper.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    // style: ,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.upload,
                      color: Theme.of(context).colorScheme.primary,
                      size: 100,
                    ),
                    TextButton(
                      onPressed: () async {
                        var image = await ImagePickerHandler()
                            .getImage(ImageSource.camera);
                        setState(() {
                          imageList.add(image);
                        });
                      },
                      child: const Text(
                        'صور شحنتك',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'تصفح المعرض',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      onPressed: () async {
                        var image = await ImagePickerHandler()
                            .getImage(ImageSource.gallery);
                        setState(() {
                          imageList.add(image);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQueryHelper.height * .02,
            ),
            Text(
              'الصور',
              style: TextStyleHelper.subtitle20,
            ),
            Column(
              children: List.generate(
                imageList.length,
                (index) => Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(8.r),
                      height: MediaQueryHelper.height * 0.1,
                      width: MediaQueryHelper.width * .2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          image: DecorationImage(
                              image: FileImage(imageList[index]),
                              fit: BoxFit.cover)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          imageList[index].parent.toString().split('/').last.characters.take(10).toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(),
                        ),
                        Text(
                            '${(imageList[index].readAsBytesSync().lengthInBytes.toInt() / 1000).toInt()} kb '),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          imageList.removeAt(index);
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQueryHelper.height * .04,
            ),
            CustomButton(
              onPressed: widget.onPressed,
              text: 'التالي',
              background: Theme.of(context).colorScheme.primary,
            )
          ],
        ),
      ),
    );
  }
}
