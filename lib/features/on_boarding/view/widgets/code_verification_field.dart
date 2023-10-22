import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/utilities/media_quary.dart';

class CodeVerificationField extends StatefulWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  const CodeVerificationField(
      {super.key, this.validator, required this.controller});

  @override
  State<CodeVerificationField> createState() => _CodeVerificationFieldState();
}

class _CodeVerificationFieldState extends State<CodeVerificationField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4.r),
      width: MediaQueryHelper.width * .133,
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        style: const TextStyle(
          fontSize: 30,
          height: 1.2,
        ),
        keyboardType: TextInputType.number,
        cursorRadius: const Radius.circular(16),
        /* inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ], */
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 8.r, /* horizontal: 32.r */
          ),
          
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.all(Radius.circular(16.0.r))),
        ),
      ),
    );
  }
}
