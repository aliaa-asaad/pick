import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/features/chat/presentation/screens/chat_screen.dart';
import 'package:pick_up/features/my_order/presentation/screens/driver_order_screen.dart';
import 'package:pick_up/features/profile/presentation/screens/profile_screen.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';

class DriverNavigationBar extends StatefulWidget {
  const DriverNavigationBar({super.key});

  @override
  DriverNavigationBarState createState() => DriverNavigationBarState();
}

class DriverNavigationBarState extends State<DriverNavigationBar> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex]['screen'],
      backgroundColor: Colors.white,
      bottomNavigationBar: SafeArea(
        child: Container(
          height: MediaQueryHelper.height * .085,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
           /*  boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 12.r,
                offset: const Offset(0, 0),
              ),
            ], */
            /*borderRadius: BorderRadius.circular(25), */
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              screens.length,
              (index) => InkWell(
                onTap: () {
                  setState(
                    () {
                      currentIndex = index;
                    },
                  );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      margin: EdgeInsets.only(
                        /* bottom: index == currentIndex
                            ? MediaQueryHelper.width * .01
                            : 0, */
                        right: MediaQueryHelper.width * .02,
                        left: MediaQueryHelper.width * .02,
                      ),
                      width: MediaQueryHelper.width * .11,
                      height: index == currentIndex
                          ? MediaQueryHelper.height * .005
                          : 0,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                    ),
      
                    SizedBox(height: MediaQueryHelper.width * .01),
                    SvgPicture.asset(
                      screens[index]['icon'],
                      height: MediaQueryHelper.height * .033,
                      width: MediaQueryHelper.width * .036,
                      colorFilter: index == currentIndex
                          ? ColorFilter.mode(
                              Theme.of(context).colorScheme.primary,
                              BlendMode.srcIn)
                          : ColorFilter.mode(
                              Theme.of(context).colorScheme.secondaryContainer,
                              BlendMode.srcIn),
                    ),
                    //  SizedBox(height: MediaQueryHelper.width * .01),
                    Text(
                      screens[index]['title'],
                      style: TextStyle(
                        fontSize: MediaQueryHelper.width * .03,
                        color: index == currentIndex
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondaryContainer,
                      ),
                    ),
                    SizedBox(
                      height: MediaQueryHelper.height * .01,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> screens = [
    {
      'title': 'الطلبات',
      'icon': AppImages.orders,
      'screen': const DriverOrderScreen()
    },
   /*  {
      'title': 'ارباحي',
      'icon': AppImages.revenueIcon,
      'screen': const DriverRevenueScreen()
    }, */
    {
      'title': 'الرسائل',
      'icon': AppImages.chatIcon,
      'screen': const ChatScreen()
    },
    {
      'title': 'الحساب',
      'icon': AppImages.profile,
      'screen': const ProfileScreen()
    },
  ];
}
