import 'dart:developer';
import 'dart:io';
import 'package:pick_up/config/end_points.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/features/auth/data/view_model/bloc/auth_bloc.dart';
import 'package:pick_up/features/auth/data/view_model/bloc/auth_event.dart';
import 'package:pick_up/features/on_boarding/view/widgets/check_card.dart';
import 'package:pick_up/features/on_boarding/view/widgets/check_country_card.dart';
import 'package:pick_up/handlers/localization.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class CheckCountryScreen extends StatefulWidget {
  const CheckCountryScreen({super.key});

  @override
  State<CheckCountryScreen> createState() => _CheckCountryScreenState();
}

class _CheckCountryScreenState extends State<CheckCountryScreen> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> content = [
      {
        'image': AppImages.saudiFlag,
      },
      {
        'image': AppImages.egyptFlag,
      },
    ];

    return Scaffold(
      body: SafeArea(
        bottom: Platform.isIOS ? false : true,
        child: Column(
          children: [
            Image.asset(
              AppImages.onBoarding4,
              // fit: BoxFit.cover,
              height: MediaQueryHelper.height * .45,
            ),
            const Spacer(),
            Container(
              width: MediaQueryHelper.width,
              // height: 600, // MediaQueryHelper.height * .5,
              //padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 16,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(36.r),
                      topRight: Radius.circular(36.r)),
                  color: Colors.white),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 0),
                        child: SizedBox(
                          height: 160,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: content.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: content.length,
                              childAspectRatio: 1 / .9,
                              crossAxisSpacing: MediaQueryHelper.width * .05,
                            ),
                            itemBuilder: (context, index) => CheckCountryCard(
                              color: _selectedIndex == index
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.white,
                              svgImage: content[index]['image'],
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                  log('selsected$_selectedIndex');
                                  AuthBloc.instance.countryType =
                                      _selectedIndex;
                                  /* SharedHandler.instance!.setData(
                                      SharedKeys().userType,
                                      value: AuthBloc.instance.type); */
                                  AuthBloc.instance
                                      .add(ChooseCountryTypeClick());
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      state is AuthError /* && bloc.type == -1 */
                          ? Text(
                              'بالرجاء اختيار الدولة',
                              style: TextStyleHelper.subtitle17
                                  .copyWith(fontWeight: FontWeight.bold),
                            )
                          : const SizedBox(
                              height: 20,
                            ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: CustomButton(
                            onPressed: () {
                              AuthBloc.instance.checkCountryValidation();
                            },
                            text: 'متابعة',
                            background:
                                Theme.of(context).colorScheme.secondary),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
    /* Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              color: Colors.grey.shade500.withOpacity(.1),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQueryHelper.height * .08,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      AppImages.onBoarding4,
                      // fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(color: Colors.transparent),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQueryHelper.width,
                height: MediaQueryHelper.height * .4,
                //padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 0),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36)),
                    color: Colors.white),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 0),
                          child: SizedBox(
                            height: MediaQueryHelper.height * .2,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: content.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: content.length,
                                childAspectRatio: 1 / .87,
                                crossAxisSpacing: MediaQueryHelper.width * .05,
                              ),
                              itemBuilder: (context, index) => CheckCard(
                                color: _selectedIndex == index
                                    ? Theme.of(context).colorScheme.secondary
                                    : Colors.white,
                                title: content[index]['title'],
                                image: _selectedIndex == index
                                    ? content[index]['selectedImage']
                                    : content[index]['image'],
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = index;
                                    AuthBloc.instance.type = _selectedIndex;
                                    SharedHandler.instance!.setData(
                                        SharedKeys().userType,
                                        value: AuthBloc.instance.type);
                                    log('type= ${AuthBloc.instance.type}');
                                    log('shared= ${SharedHandler.instance!.setData(SharedKeys().userType, value: AuthBloc.instance.type)}');
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        state is AuthError /* && bloc.type == -1 */
                            ? Text(
                                'بالرجاء اختيار نوع الحساب',
                                style: TextStyleHelper.subtitle19,
                              )
                            : const SizedBox(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: CustomButton(
                              onPressed: () {
                                AuthBloc.instance.checkValidation();
                              },
                              text: 'متابعة',
                              background:
                                  Theme.of(context).colorScheme.secondary),
                        )
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
   */
  }
}
