import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/features/notification/data/view_model/cubit/notification_cubit.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        toolbarHeight: MediaQueryHelper.height * .1,
        backgroundColor: Colors.white,
        title: const Text(
          'الاشعارات',
        ),
        titleTextStyle: TextStyleHelper.subtitle19.copyWith(
            color: Theme.of(context).colorScheme.primary, fontFamily: 'Cairo'),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20.r),
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if(state is NotificationLoading){
              return const Center(child: CircularProgressIndicator(),);
            }
            else if(state is NotificationError){
              return const Center(child: Text('حدث خطأ ما'),);
            }
            return Column(
              children: List.generate(
                  NotificationCubit
                      .instance.notificationModel.notifications!.length,
                  (index) => Container(
                        padding: EdgeInsets.fromLTRB(8.r, 4.r, 8.r, 12.r),
                        margin: EdgeInsets.only(bottom: 12.h),
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {},
                                icon: const Icon(Icons.close)),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQueryHelper.width * .02,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      NotificationCubit
                                                          .instance
                                                          .notificationModel
                                                          .notifications![index]
                                                          .title!,
                                                      style: TextStyleHelper.body15
                                                          .copyWith(
                                                              color: const Color(
                                                                  0xff20384B)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  NotificationCubit
                                                      .instance
                                                      .notificationModel
                                                      .notifications![index]
                                                      .body!,
                                                  style: TextStyleHelper.caption11
                                                      .copyWith(
                                                          fontWeight: FontWeight.normal,
                                                          color:
                                                              const Color(0xff334D64)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0.r),
                                    child: Text(
                                      NotificationCubit.instance.notificationModel
                                          .notifications![index].createdAt!,
                                      style: TextStyleHelper.caption11.copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: const Color(0xff334D64)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
            );
          },
        ),
      )),
    );
  }
}
