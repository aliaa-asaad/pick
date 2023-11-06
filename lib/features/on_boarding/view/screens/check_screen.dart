import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/features/auth/data/view_model/bloc/auth_bloc.dart';
import 'package:pick_up/features/on_boarding/view/widgets/check_card.dart';
import 'package:pick_up/handlers/localization.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({super.key});

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> content = [
      {
        'title': getLang(context, 'client'),
        'image': AppImages.unSelectedClient,
        'selectedImage': AppImages.selectedClient
      },
      {
        'title': 'مندوب',
        'image': AppImages.unSelectedEmployee,
        'selectedImage': AppImages.selectedEmployee
      }
    ];

    return Scaffold(
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
                                style: TextStyleHelper.subtitle20,
                              )
                            : const SizedBox(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: CustomButton(
                              onPressed: () {AuthBloc.instance.checkValidation();
                               
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
  }
}
