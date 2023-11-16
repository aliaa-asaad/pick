import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/features/chat/data/model/chat_model.dart';
import 'package:pick_up/features/chat/data/view_model/cubit/chat_cubit.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/handlers/url_launcher_handler.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQueryHelper.height * .1,
        backgroundColor: Colors.white,
        title: const Text(
          'الرسائل',
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
          child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state is ChatLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ChatError) {
                return const Center(
                  child: Text('حدث خطأ ما'),
                );
              }
              return  SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
                child: Column(
                  children: List.generate(
                      ChatCubit.instance.chatModel.chat!.length,
                      (index) => InkWell(
                            onTap: () async {
                              await UrlLauncherHandler.openWhatsApp(phoneNumber:'+201004307575'
                                 /*  SharedHandler.instance!.getData(
                                              key: SharedKeys().userType,
                                              valueType: ValueType.int) ==
                                          1
                                      ? ChatCubit.instance.chatModel.chat![index]
                                          .clientNumber!
                                      : ChatCubit.instance.chatModel.chat![index]
                                          .driverNumber! */);
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: MediaQueryHelper.height * .01,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQueryHelper.width * .02,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          SharedHandler.instance!.getData(
                                                      key: SharedKeys().userType,
                                                      valueType: ValueType.int) ==
                                                  1
                                              ? ChatCubit.instance.chatModel
                                                  .chat![index].clientName!
                                              : ChatCubit.instance.chatModel
                                                  .chat![index].driverName!,
                                          style: TextStyleHelper.subtitle17
                                              .copyWith(
                                                  color: const Color(0xff4F5E7B)),
                                        ),
                                        Text(
                                          SharedHandler.instance!.getData(
                                                      key: SharedKeys().userType,
                                                      valueType: ValueType.int) ==
                                                  1
                                              ? 'عميل طلب رقم ${ChatCubit.instance.chatModel.chat![index].orderId}'
                                              : 'مندوب طلب رقم ${ChatCubit.instance.chatModel.chat![index].orderId}',
                                          style: TextStyleHelper.button13.copyWith(
                                              fontWeight: FontWeight.normal,
                                              color: const Color(0xff4F5E7B)
                                                  .withOpacity(.5)),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    SvgPicture.asset(
                                      AppImages.whatsappIcon,
                                      // width: 20.r,
                                      height: MediaQueryHelper.height * .05,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQueryHelper.height * .01,
                                ),
                                const Divider(
                                  color: Colors.white,
                                  thickness: 2,
                                )
                              ],
                            ),
                          )),
                ),
              );
            },
          )),
    );
  }
}
