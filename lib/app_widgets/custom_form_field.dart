import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/utilities/images.dart';

class CustomFormField extends StatefulWidget {
  final String? hintText;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool isAuth;
  final Color? fillColor;
  final String icon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final Widget? iconWidget;
  final Color? hintColor;
  const CustomFormField({ 
    super.key,
    required this.hintText,
    required this.keyboardType,
    this.isPassword = false,
    required this.controller,
    this.icon = '',
    this.validator,
    this.isAuth = true,
    this.fillColor,
    this.iconWidget,
    this.hintColor, 
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      textInputAction: TextInputAction.next,
      obscureText: widget.isPassword ? passwordVisible : false,
      controller: widget.controller,
      enabled: true,
      style: const TextStyle(
        height: 1.4,
        //fontSize: 16.sp,
      ),
      decoration: InputDecoration(
   
        fillColor: widget.fillColor ?? Colors.white,
        
        filled: true,
        suffixIcon: widget.isAuth
            ? widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    icon: passwordVisible
                        ? SvgPicture.asset(
                            AppImages.invisiblePassword,
                          )
                        : SvgPicture.asset(
                            AppImages.visiblePassword,
                          ),
                  )
                : const SizedBox()
            : Padding(
              padding:  EdgeInsets.all(12.0.r),
              child: widget.iconWidget,
            ),
        prefixIcon: widget.isAuth
            ? Padding(
                padding:  EdgeInsets.all(12.0.r),
                child: SvgPicture.asset(
                  widget.icon,
                ),
              )
            : null,
        hintStyle: TextStyle(color: widget.hintColor ?? Colors.grey),
        hintText: widget.hintText,
        border: OutlineInputBorder(
          /* borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.green,
          ), */
          borderRadius: BorderRadius.all(
            Radius.circular(16.0.r),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(16.0.r),
          ),
        ),
      ),
    );
  }
}
