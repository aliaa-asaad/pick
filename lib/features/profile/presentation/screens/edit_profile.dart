import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/app_widgets/custom_form_field.dart';
import 'package:pick_up/core/validator.dart';
import 'package:pick_up/features/profile/data/view_model/bloc/profile_bloc.dart';
import 'package:pick_up/handlers/image_picker_handler.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with Validations {
      File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQueryHelper.height * .1,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('الحساب'),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        elevation: .8,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            24.r,
            32.r,
            24.r,
            24.r,
          ),
          child: Form(
            key: ProfileBloc.instance.formKey,
            child: InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60.r,
                            backgroundColor: Colors.grey[300],
                            child: state is ProfileLoading
                                ? CircleAvatar(
                                    radius: 55.r,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    child: const CircularProgressIndicator())
                                : CircleAvatar(
                                    foregroundImage: NetworkImage(
                                      SharedHandler.instance!.getData(
                                          key: SharedKeys().user,
                                          valueType: ValueType.map)['imageUrl'],
                                    ),
                                    radius: 55.r,
                                  ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () async {
                              setState(() {
                                image=null;
                              });
                                image=await ImagePickerHandler().getSingleImage();
                                ProfileBloc.instance.image =
                                    image;
                                ProfileBloc.instance.add(UploadImage());
                              },
                              child: CircleAvatar(
                                radius: 20.r,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey.shade300,
                                  child: SvgPicture.asset(
                                      AppImages.uploadImageIcon),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),
                      CustomFormField(
                          validator: isValidName,
                          hintText: 'الاسم الكامل',
                          iconWidget: SvgPicture.asset(AppImages.editFieldIcon),
                          isAuth: false,
                          keyboardType: TextInputType.name,
                          controller: ProfileBloc.instance.fullNameController),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),
                      CustomFormField(
                          validator: isValidPhone,
                          iconWidget: SvgPicture.asset(AppImages.editFieldIcon),
                          isAuth: false,
                          hintText: ProfileBloc.instance.client.phoneNumber!,
                          keyboardType: TextInputType.number,
                          controller:
                              ProfileBloc.instance.phoneNumberController),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),
                      CustomFormField(
                          validator: isValidEmail,
                          iconWidget: SvgPicture.asset(AppImages.editFieldIcon),
                          isAuth: false,
                          hintText: ProfileBloc.instance.client.email!,
                          keyboardType: TextInputType.emailAddress,
                          controller: ProfileBloc.instance.emailController),
                      const Spacer(),
                      state is ProfileError
                          ? Text(
                              'هناك خطا في البيانات',
                              style: TextStyleHelper.subtitle20,
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),
                      CustomButton(
                        width: state is ProfileLoading
                            ? MediaQueryHelper.width * .13
                            : MediaQueryHelper.width,
                        onPressed: () {
                          if (ProfileBloc.instance.formKey.currentState!
                              .validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم حفظ البيانات')),
                            );
                            ProfileBloc.instance.add(EditProfile());
                          } else {
                            log('not valid');
                          }
                        },
                        child: state is ProfileLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'حفظ التعديلات',
                                style: TextStyleHelper.subtitle20.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                        /*  textColor: textColor */
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
