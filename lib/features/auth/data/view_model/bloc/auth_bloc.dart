import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pick_up/core/user_model.dart';
import 'package:pick_up/core/validator.dart';
import 'package:pick_up/features/auth/data/model/auth_repo.dart';
import 'package:pick_up/features/auth/data/model/otp_model.dart';
import 'package:pick_up/features/auth/data/model/forget_password_model.dart';
import 'package:pick_up/features/auth/data/view_model/bloc/auth_event.dart';
import 'package:pick_up/features/auth/data/view_model/otp_bloc/otp_bloc.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with Validations {
  AuthBloc() : super(AuthInitial()) {
    //  on<LoginClick>(_login);

    //   on<RegisterClick>(_register);
    // on<CodeVerificationClick>(_verifyCode);
    on<ChooseTypeClick>(_chooseType);
    on<ForgetPasswordClick>(_forgetPassword);
    on<NewPasswordClick>(_newPassword);
    on<LogoutClick>(_logout);
  }
  static AuthBloc get instance =>
      BlocProvider.of(AppRoutes.navigatorState.currentContext!);
  final AuthRepo _authRepo = AuthRepo();
  late UserModel userModel;
 // late EmailVerifiactionModel _emailVerifiactionModel;
  late ForgetPasswordModel _forgetPasswordModel;
  int type = -1;
  bool isForgetPassword = false;
  /* TextEditingController fullNameController = TextEditingController();
  String fullNameError = ''; */
  TextEditingController confirmPasswordController = TextEditingController();
  String confirmPasswordError = '';
  /* TextEditingController phoneNumberController = TextEditingController();
  String phoneNumberError = ''; */
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

  //===========================

  /*  bool _registerValidation() {
    phoneNumberError = isValidPhoneBloc(phoneNumberController.text);
    passwordError = isValidPasswordBloc(passwordController.text);
    fullNameError = isValidNameBloc(fullNameController.text);
    confirmPasswordError = isValidConfirmPasswordBloc(
        passwordController.text, confirmPasswordController.text);
    emailError = isValidEmailBloc(emailController.text);
    return phoneNumberError.isEmpty &&
        fullNameError.isEmpty &&
        passwordError.isEmpty &&
        confirmPasswordError.isEmpty &&
        emailError.isEmpty;
  } */
//=========================

  bool _validateCode() {
    codeError1 = isValidCodeBloc(codeController1.text);
    codeError2 = isValidCodeBloc(codeController2.text);
    codeError3 = isValidCodeBloc(codeController3.text);
    codeError4 = isValidCodeBloc(codeController4.text);
    return codeError1.isEmpty &&
        codeError2.isEmpty &&
        codeError3.isEmpty &&
        codeError4.isEmpty;
  }

  /*  bool _loginValidation() {
    phoneNumberError = isValidPhoneBloc(phoneNumberController.text);
    passwordError = isValidPasswordBloc(passwordController.text);
    return phoneNumberError.isEmpty && passwordError.isEmpty;
  } */

  bool _resetPasswordValidation() {
    confirmPasswordError = isValidPhoneBloc(confirmPasswordController.text);
    passwordError = isValidPasswordBloc(passwordController.text);
    return confirmPasswordError.isEmpty && passwordError.isEmpty;
  }

  checkValidation() {
    emit(AuthLoading());

    if (type != -1) {
      AppRoutes.pushNamedNavigator(routeName: Routes.auth);
      emit(AuthLoaded());
    } else {
      log('check else error');
      emit(AuthError());
    }
  }

  _chooseType(AuthEvent events, Emitter emit) async {
    emit(AuthLoading());
    try {
      SharedHandler.instance!.setData(SharedKeys().userType, value: type);
      emit(AuthLoaded());
    } catch (e) {
      log('choose type error :${e.toString()}');
      emit(AuthError());
    }
  }

    _forgetPassword(AuthEvent events, Emitter emit) async {
    emit(AuthLoading());
    try {
      Map<String, dynamic> data = {
        'email': emailController.text,
        'type': type,
      };
      log(data.toString());
      _forgetPasswordModel = await _authRepo.forgetPasswordRequest(data);
      log('verified');
      /* SharedHandler.instance!
          .setData(SharedKeys().user, value: _userModel.client!.toJson());
      SharedHandler.instance!.setData(SharedKeys().isLogin, value: true);
      SharedHandler.instance!
          .setData(SharedKeys().token, value: _userModel.authToken);
      SharedHandler.instance!.setData(SharedKeys().isFirstTime, value: true); */
      //SharedHandler.instance!.setData(SharedKeys().userType, value: type);
      AppRoutes.pushNamedNavigator(routeName: Routes.emailVerification);

      emit(AuthLoaded());
    } catch (e) {
      log('forget password error :${e.toString()}');
      emit(AuthError());
    }
  }

  _newPassword(AuthEvent events, Emitter emit) async {
    emit(AuthLoading());
    try {
      /* if (_resetPasswordValidation()) { */
      Map<String, dynamic> data = {
        'email': emailController.text,
        'otp': [
          OTPBloc.instance.codeController1.text,
          OTPBloc.instance.codeController2.text,
          OTPBloc.instance.codeController3.text,
          OTPBloc.instance.codeController4.text,
        ].join(),
        "password": passwordController.text,
        "type": SharedHandler.instance!
            .getData(key: SharedKeys().userType, valueType: ValueType.int)
      };
      userModel = await _authRepo.resetPasswordRequest(data);
      await SharedHandler.instance!
          .setData(SharedKeys().user, value: userModel.client!.toJson());
      await SharedHandler.instance!.setData(SharedKeys().isLogin, value: true);
      await SharedHandler.instance!
          .setData(SharedKeys().isNotFirstTime, value: true);
      //SharedHandler.saveLoginData(_authModel);
      //SharedHandler.setData(_authModel);
      //log(' ${_loginModel.client!.accessToken!}');
      /* _userModel.client!.isValid!
            ?  */
      SharedHandler.instance!.getData(
                  key: SharedKeys().userType, valueType: ValueType.int) ==
              0
          ? AppRoutes.pushNamedNavigator(
              routeName: Routes.clientNavBar, replacementAll: true)
          : AppRoutes.pushNamedNavigator(
              routeName: Routes.driverNavBar, replacementAll: true);
      /* : AppRoutes.pushNamedNavigator(
                routeName: Routes.emailVerification, replacement: true); */
      emit(AuthLoaded());
      //}
    } catch (e) {
      log('reset Password :${e.toString()}');
      emit(AuthError());
    }
  }

  clearData() {
    /* fullNameController.clear();
    phoneNumberController.clear(); */
    passwordController.clear();
    confirmPasswordController.clear();
    emailController.clear();
    codeController1.clear();
    codeController2.clear();
    codeController3.clear();
    codeController4.clear();
  }

  _logout(AuthEvent events, Emitter emit) async {
    emit(AuthLoading());
    try {
      SharedHandler.instance!.clear(keys: [
        SharedKeys().user,
        SharedKeys().isLogin,
        SharedKeys().token,
        SharedKeys().userType,
      ]);
      /*  fullNameController.clear();
      phoneNumberController.clear(); */
      passwordController.clear();
      confirmPasswordController.clear();
      emailController.clear();
      OTPBloc.instance.codeController1.clear();
      OTPBloc.instance.codeController2.clear();
      OTPBloc.instance.codeController3.clear();
      OTPBloc.instance.codeController4.clear();
      type = -1;
      isForgetPassword = false;
      AppRoutes.pushNamedNavigator(
          routeName: Routes.check, replacementAll: true);
    } catch (e) {
      log('logout error :${e.toString()}');
      emit(AuthError());
    }
  }
}
