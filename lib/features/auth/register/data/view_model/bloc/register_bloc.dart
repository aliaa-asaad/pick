import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pick_up/core/email_verification_model.dart';
import 'package:pick_up/core/user_model.dart';
import 'package:pick_up/core/validator.dart';
import 'package:pick_up/features/auth/register/data/model/register_repo.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> with Validations {
  RegisterBloc() : super(RegisterInitial()) {
    // on<ClientRegisterClick>(_register);
    on<RegisterClick>(_register);
    on<CodeVerificationClick>(_verifyCode);
    /*  on<RegisterEvent>((event, emit) {
      // TODO: implement event handler
    }); */
  }
  final RegisterRepo _registerRepo = RegisterRepo();
  //late AuthModel _authModel;
  late UserModel _userModel;
  late EmailVerifiactionModel _emailVerifiactionModel;
  int type = -1;
  TextEditingController fullNameController = TextEditingController();
  String fullNameError = '';
  TextEditingController confirmPasswordController = TextEditingController();
  String confirmPaswwordError = '';
  TextEditingController phoneNumberController = TextEditingController();
  String phoneNumberError = '';
  TextEditingController emailController = TextEditingController();
  String emailError = '';
  TextEditingController passwordController = TextEditingController();
  String passwordError = '';

  //===========================
  TextEditingController codeController1 = TextEditingController();
  String codeError1 = '';
  TextEditingController codeController2 = TextEditingController();
  String codeError2 = '';
  TextEditingController codeController3 = TextEditingController();
  String codeError3 = '';
  TextEditingController codeController4 = TextEditingController();
  String codeError4 = '';
  TextEditingController codeController5 = TextEditingController();
  String codeError5 = '';
  TextEditingController codeController6 = TextEditingController();
  String codeError6 = '';
  
  //===========================

  bool _validate() {
    phoneNumberError = isValidPhoneBloc(phoneNumberController.text);
    passwordError = isValidPasswordBloc(passwordController.text);
    fullNameError = isValidNameBloc(fullNameController.text);
    confirmPaswwordError = isValidConfirmPasswordBloc(
        passwordController.text, confirmPasswordController.text);
    emailError = isValidEmailBloc(emailController.text);
    return phoneNumberError.isEmpty &&
        fullNameError.isEmpty &&
        passwordError.isEmpty &&
        confirmPaswwordError.isEmpty &&
        emailError.isEmpty;
  }

  bool _validateCode() {
    codeError1 = isValidCodeBloc(codeController1.text);
    codeError2 = isValidCodeBloc(codeController2.text);
    codeError3 = isValidCodeBloc(codeController3.text);
    codeError4 = isValidCodeBloc(codeController4.text);
    codeError5 = isValidCodeBloc(codeController5.text);
    codeError6 = isValidCodeBloc(codeController6.text);
    return codeError1.isEmpty &&
        codeError2.isEmpty &&
        codeError3.isEmpty &&
        codeError4.isEmpty &&
        codeError5.isEmpty &&
        codeError6.isEmpty;
  }

  _register(RegisterEvent events, Emitter emitter) async {
    emit(RegisterLoading());
    if (_validate()) {
      Map<String, dynamic> data = {
        'fullName': fullNameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'phoneNumber': phoneNumberController.text,
      };
      _userModel = await _registerRepo.registerRequest(data);
      log('success');
      /* SharedHandler.instance!
          .setData(SharedKeys().user, value: _userModel.client!.toJson());
      SharedHandler.instance!.setData(SharedKeys().isLogin, value: true);
      SharedHandler.instance!
          .setData(SharedKeys().token, value: _userModel.authToken);
      SharedHandler.instance!.setData(SharedKeys().isFirstTime, value: true); */
      //SharedHandler.instance!.setData(SharedKeys().userType, value: type);
      AppRoutes.pushNamedNavigator(
          routeName: Routes.emailVerification, replacement: true);

      emit(RegisterLoaded());
    } else {
      emit(RegisterError());
    }
  }

  _verifyCode(RegisterEvent events, Emitter emitter) async {
    emit(RegisterLoading());
    try {
      Map<String, dynamic> data = {
        'email': emailController.text,
        'otp': [
          codeController1.text,
          codeController2.text,
          codeController3.text,
          codeController4.text,
          codeController5.text,
          codeController6.text,
        ].join(),
        'type': type,
      };
      log(data.toString());
      _emailVerifiactionModel =
          await _registerRepo.emailVerificationRequest(data);
      log('verified');
      SharedHandler.instance!
          .setData(SharedKeys().user, value: _userModel.client!.toJson());
      SharedHandler.instance!.setData(SharedKeys().isLogin, value: true);
      SharedHandler.instance!
          .setData(SharedKeys().token, value: _userModel.authToken);
      SharedHandler.instance!.setData(SharedKeys().isFirstTime, value: true);
      //SharedHandler.instance!.setData(SharedKeys().userType, value: type);
      AppRoutes.pushNamedNavigator(routeName: Routes.navBar, replacement: true);

      emit(RegisterLoaded());
    } catch (e) {
      log(e.toString());
      emit(RegisterError());
    }
  }

  /*  _update(AppEvents event, Emitter emit) async => emit(Start()); */
  /* _register(ClientRegisterEvent events, Emitter emit) async {
    emit(ClientRegisterLoading());
    if (_validate()) {
      Map<String, dynamic> data = {
        "mobilePhone": phoneNumberController.text,
        "firstName": fullNameController.text,
        "lastName": lastNameController.text,
        "password": password.text,
        'email': emailController.text,
        /* "password_confirmation": confirmPassword.text,
        "from": startPoint.text,
        "to": endPoint.text, */
      };
      _authModel = await _registerRepo.registerRequest(data);
      SharedHandler.instance!
          .setData(SharedKeys().user, value: _authModel.client!.toJson());
      SharedHandler.instance!.setData(SharedKeys().isLogin, value: true);
      SharedHandler.instance!.setData(SharedKeys().isFirstTime, value: true);
      AppRoutes.pushNamedNavigator(routeName: Routes.navBar, replacement: true);
      emit(ClientRegisterLoaded());
    } else {
      emit(ClientRegisterError());
    }
  }
 */
}
