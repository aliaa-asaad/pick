import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pick_up/core/user_model.dart';
import 'package:pick_up/core/validator.dart';
import 'package:pick_up/features/auth/data/model/auth_repo.dart';
import 'package:pick_up/features/auth/data/model/email_verification_model.dart';
import 'package:pick_up/features/auth/data/model/forget_password_model.dart';
import 'package:pick_up/features/auth/data/view_model/bloc/auth_event.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with Validations {
  AuthBloc() : super(AuthInitial()) {
    on<LoginClick>(_login);
    on<RegisterClick>(_register);
    on<CodeVerificationClick>(_verifyCode);
    on<ForgetPasswordClick>(_forgetPassword);
    on<NewPasswordClick>(_newPassword);
    on<LogoutClick>(_logout);
    /* <loginEvent>((event, emit) async {
      if (event is loginInitial) {
        emit(loginInitial());
      } else if (event is loginLoading) {
        emit(loginLoading());
      } else if (event is loginLoaded) {
        emit(loginLoaded());
      } else if (event is loginError) {
        emit(loginError());
      }
    }); */
  }
  final AuthRepo _authRepo = AuthRepo();
  late UserModel _userModel;
  late EmailVerifiactionModel _emailVerifiactionModel;
  late ForgetPasswordModel _forgetPasswordModel;
  int type = -1;
  bool isForgetPassword = false;
  TextEditingController fullNameController = TextEditingController();
  String fullNameError = '';
  TextEditingController confirmPasswordController = TextEditingController();
  String confirmPasswordError = '';
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

  bool _registerValidation() {
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
  }
//=========================

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

  bool _loginValidation() {
    phoneNumberError = isValidPhoneBloc(phoneNumberController.text);
    passwordError = isValidPasswordBloc(passwordController.text);
    return phoneNumberError.isEmpty && passwordError.isEmpty;
  }

  bool _resetPasswordValidation() {
    confirmPasswordError = isValidPhoneBloc(confirmPasswordController.text);
    passwordError = isValidPasswordBloc(passwordController.text);
    return confirmPasswordError.isEmpty && passwordError.isEmpty;
  }

  _login(AuthEvent events, Emitter emit) async {
    emit(AuthLoading());
    try {
      if (_loginValidation()) {
        Map<String, dynamic> data = {
          "phoneNumber": phoneNumberController.text,
          "password": passwordController.text,
          "type": SharedHandler.instance!
              .getData(key: SharedKeys().userType, valueType: ValueType.int)
        };
        _userModel = await _authRepo.loginRequest(data);
        SharedHandler.instance!
            .setData(SharedKeys().user, value: _userModel.client!.toJson());
        SharedHandler.instance!
            .setData(SharedKeys().token, value: _userModel.authToken);
        log('login token: ${_userModel.authToken}');
        SharedHandler.instance!.setData(SharedKeys().isLogin, value: true);
        SharedHandler.instance!.setData(SharedKeys().isFirstTime, value: false);
        //SharedHandler.saveLoginData(_authModel);
        //SharedHandler.setData(_authModel);
        //log(' ${_loginModel.client!.accessToken!}');
        _userModel.client!.isValid!
            ? AppRoutes.pushNamedNavigator(
                routeName: Routes.navBar, replacement: true)
            : AppRoutes.pushNamedNavigator(
                routeName: Routes.emailVerification, replacement: true);
        emit(AuthLoaded());
      }
    } catch (e) {
      log('login error :${e.toString()}');
      emit(AuthError());
    }
  }

  _register(AuthEvent events, Emitter emitter) async {
    emit(AuthLoading());
    try {
      if (_registerValidation()) {
        Map<String, dynamic> data = {
          'fullName': fullNameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'phoneNumber': phoneNumberController.text,
        };
        _userModel = await _authRepo.registerRequest(data);
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

        emit(AuthLoaded());
      }
    } catch (e) {
      log('register error :${e.toString()}');
      emit(AuthError());
    }
  }

  _verifyCode(AuthEvent events, Emitter emitter) async {
    emit(AuthLoading());
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
      _emailVerifiactionModel = await _authRepo.emailVerificationRequest(data);
      log('verified');
      log('isForgetPassword : $isForgetPassword');
      if (isForgetPassword == false) {
        log('aliaa');
        log('model: ${_userModel.client!.toJson()}');
        await SharedHandler.instance!
            .setData(SharedKeys().user, value: _userModel.client!.toJson());
        await SharedHandler.instance!
            .setData(SharedKeys().isLogin, value: true);
        log('token: ${_userModel.authToken}');
        await SharedHandler.instance!
            .setData(SharedKeys().token, value: _userModel.authToken);
        await SharedHandler.instance!
            .setData(SharedKeys().isFirstTime, value: false);
      }

      //SharedHandler.instance!.setData(SharedKeys().userType, value: type);
      isForgetPassword
          ? AppRoutes.pushNamedNavigator(routeName: Routes.newPassword)
          : AppRoutes.pushNamedNavigator(
              routeName: Routes.navBar, replacement: true);

      emit(AuthLoaded());
    } catch (e) {
      log('verify code error :${e.toString()}');
      emit(AuthError());
    }
  }

  _forgetPassword(AuthEvent events, Emitter emitter) async {
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
          codeController1.text,
          codeController2.text,
          codeController3.text,
          codeController4.text,
          codeController5.text,
          codeController6.text,
        ].join(),
        "password": passwordController.text,
        "type": SharedHandler.instance!
            .getData(key: SharedKeys().userType, valueType: ValueType.int)
      };
      _userModel = await _authRepo.resetPasswordRequest(data);
      await SharedHandler.instance!
          .setData(SharedKeys().user, value: _userModel.client!.toJson());
      await SharedHandler.instance!.setData(SharedKeys().isLogin, value: true);
      await SharedHandler.instance!
          .setData(SharedKeys().isFirstTime, value: true);
      //SharedHandler.saveLoginData(_authModel);
      //SharedHandler.setData(_authModel);
      //log(' ${_loginModel.client!.accessToken!}');
      /* _userModel.client!.isValid!
            ?  */
      AppRoutes.pushNamedNavigator(routeName: Routes.navBar, replacement: true);
      /* : AppRoutes.pushNamedNavigator(
                routeName: Routes.emailVerification, replacement: true); */
      emit(AuthLoaded());
      //}
    } catch (e) {
      log('reset Password :${e.toString()}');
      emit(AuthError());
    }
  }

  _logout(AuthEvent events, Emitter emitter) async {
    emit(AuthLoading());
    try {
      SharedHandler.instance!.clear(keys: [
        SharedKeys().user,
        SharedKeys().isLogin,
        SharedKeys().token,
        SharedKeys().isFirstTime
      ]);
      isForgetPassword = false;
      AppRoutes.pushNamedNavigator(routeName: Routes.check, replacement: true);
    } catch (e) {
      log('logout error :${e.toString()}');
      emit(AuthError());
    }
  }
}
