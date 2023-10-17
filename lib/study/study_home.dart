import 'dart:developer';

import 'package:flutter/material.dart';

class StudyHome extends StatefulWidget {
  const StudyHome({super.key});

  @override
  State<StudyHome> createState() => _StudyHomeState();
}

class _StudyHomeState extends State<StudyHome> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   String? isValidEmail(String? email){
    if(email!.isEmpty){
      return "الرجاء ادخال البريد الألكتروني بشكل صحيح";
    }
    else if (
      !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)
    ){
      return "الرجاء ادخال البريد الألكتروني";
    }
    return "";
  }
  @override
  Widget build(BuildContext context) {
    String name = '';
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      //  FocusScope.of(context).requestFocus(FocusNode());
                      name = value;
                    },
                    validator: isValidEmail,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          log(name);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        } else
                          log('not valid');
                        /* log('${_formKey.currentState!.}'); */
                      },
                      child: const Text('Submit'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
