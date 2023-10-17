import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/features/order/data/view_model/bloc/order_bloc.dart';
import 'package:pick_up/features/order/presentation/screens/order_confirm_screen.dart';
import 'package:pick_up/features/order/presentation/screens/order_data_screen.dart';
import 'package:pick_up/features/order/presentation/screens/order_image_screen.dart';
import 'package:pick_up/features/order/presentation/screens/order_location_screen.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> icons = [
      {
        'icon': AppImages.orderIcon1,
        'title': '',
        'body': BlocProvider(
          create: (context) => OrderBloc(),
          child: OrderDataScreen(
            onPressed: () {
              setState(() {
                currentStep++;
              });
            },
          ),
        )
      },
      {
        'icon': AppImages.orderIcon2,
        'title': '',
        'body': BlocProvider(
          create: (context) => OrderBloc(),
          child: OrderImageScreen(
            onPressed: () {
              setState(() {
                currentStep++;
              });
            },
          ),
        )
      },
      {
        'icon': AppImages.orderIcon3,
        'title': '',
        'body': OrderLocationScreen(
          onPressed: () {
            setState(() {
              currentStep++;
            });
          },
        ),
      },
      {
        'icon': AppImages.orderIcon3,
        'title': '',
        'body': const OrderConfirmScreen()
      }
    ];

    return Scaffold(
      appBar: AppBar(
          actions: const [
            Icon(Icons.notifications),
          ],
          title: const Text('إنشاء طلب جديد'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () async {
              if (currentStep == 0) {
                Navigator.pop(context);
              }
              setState(() {
                currentStep--;
              });
            },
            icon: const Icon(Icons.arrow_back),
          )),
      body: Column(children: [
        Container(
          color: Theme.of(context).colorScheme.primary,
          height: MediaQueryHelper.height * .1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              icons.length,
              (index) => Column(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: currentStep > index
                        ? Colors.green
                        : currentStep == index
                            ? Colors.white
                            : Theme.of(context).colorScheme.primary,
                    child: currentStep > index
                        ? const Icon(Icons.check_circle, color: Colors.white)
                        : SvgPicture.asset(
                            icons[index]['icon'],
                            color: currentStep == index
                                ? Theme.of(context).colorScheme.primary
                                : Colors.white,
                          ),
                  ),
                  Text(
                    'بيانات الطلب',
                    style: TextStyle(
                        color:
                            currentStep == index ? Colors.white : Colors.black),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
            child:
                currentStep < 0 ? const SizedBox() : icons[currentStep]['body'])
      ]),
    );
  }
}
