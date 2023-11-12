import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/features/auth/data/view_model/bloc/auth_bloc.dart';
import 'package:pick_up/features/auth/data/view_model/bloc/auth_event.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> content = [
      {
        'icon': AppImages.orderIcon4,
        'title': 'سجل الفواتير',
        'route': Routes.bills
      },
      {
        'icon': AppImages.settingsIcon,
        'title': 'تعديل الحساب',
        'route': Routes.editProfile
      },
      {'icon': AppImages.infoIcon, 'title': 'عن بيك أب', 'route': Routes.about},
      {
        'icon': AppImages.localizationIcon,
        'title': 'اللغة',
        'route': Routes.localization
      },
      {
        'icon': AppImages.callCenterIcon,
        'title': 'خدمة العملاء',
        'route': Routes.callCenter
      },
      {
        'icon': AppImages.policyIcon,
        'title': 'الشروط والاحكام ',
        'route': Routes.policy
      },
      {
        'icon': AppImages.logoutIcon,
        'title': 'تسجيل الخروج',
        'route': Routes.check
      },
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          // physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: 32.h),
          child: Column(children: [
            CircleAvatar(
              radius: 55.r,
              backgroundImage: NetworkImage(SharedHandler.instance!.getData(
                  key: SharedKeys().user,
                  valueType: ValueType.map)['imageUrl']),
            ),
            SizedBox(
              height: MediaQueryHelper.height * .01,
            ),
            Text(
              SharedHandler.instance!.getData(
                  key: SharedKeys().user, valueType: ValueType.map)['fullName'],
              style: TextStyleHelper.subtitle17.copyWith(color: Colors.white),
            ),
            SizedBox(
              height: MediaQueryHelper.height * .01,
            ),
            Text(
              SharedHandler.instance!.getData(
                  key: SharedKeys().user,
                  valueType: ValueType.map)['phoneNumber'],
              style: TextStyleHelper.subtitle17.copyWith(color: Colors.white),
            ),
            SizedBox(
              height: MediaQueryHelper.height * .06,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16.r),
                ),
              ),
              width: MediaQueryHelper.width,
              child: Column(
                children: List.generate(
                  content.length,
                  (index) => InkWell(
                    onTap: () {
                      AppRoutes.pushNamedNavigator(
                          routeName: content[index]['route']);
                      if (index == content.length - 1) {
                        AuthBloc.instance.add(LogoutClick());
                      }
                    },
                    child: ListTile(
                      minLeadingWidth: 20.w,
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: index == content.length - 1
                            ? Colors.red
                            : Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        "${content[index]['title']}",
                        style: TextStyleHelper.subtitle17.copyWith(
                          fontWeight: FontWeight.bold,
                          color: index == content.length - 1
                              ? Colors.red
                              : const Color(0xff4F5E7B),
                        ),
                      ),
                      leading: SvgPicture.asset(
                        content[index]['icon'],
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
