import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pick_up/core/user_model.dart';
import 'package:pick_up/core/validator.dart';
import 'package:pick_up/features/auth/data/model/login/login_repo.dart';
import 'package:pick_up/features/notification/data/view_model/cubit/notification_cubit.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with Validations {
  LoginBloc() : super(LoginInitial()) {
    /* on<LoginEvent>((event, emit) {
     
    }); */
    on<LoginPost>(_login);
  }
  ///////////instance//////////////
  static LoginBloc get instance =>
      BlocProvider.of(AppRoutes.navigatorState.currentContext!);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  /////////////////models////////////////
  final LoginRepo _loginRepo = LoginRepo();
  UserModel userModel = UserModel();
  Driver driver = Driver();

////////////////////variables/////////////
  TextEditingController phoneNumberController = TextEditingController();
  String phoneNumberError = '';

  TextEditingController passwordController = TextEditingController();
  String passwordError = '';
///////////////////validation////////////////
  bool _loginValidation() {
    phoneNumberError = isValidPhoneBloc(phoneNumberController.text);
    passwordError = isValidPasswordBloc(passwordController.text);
    return phoneNumberError.isEmpty && passwordError.isEmpty;
  }

//////////////////methods///////////////////
  _login(LoginEvent events, Emitter emit) async {
    emit(LoginLoading());
    try {
      if (_loginValidation()) {
        Map<String, dynamic> data = {
          "phoneNumber": phoneNumberController.text,
          "password": passwordController.text,
          "type": SharedHandler.instance!
              .getData(key: SharedKeys().userType, valueType: ValueType.int)
        };
        if (SharedHandler.instance!.getData(
                key: SharedKeys().userType, valueType: ValueType.int) ==
            0) {
          userModel = await _loginRepo.loginRequest(data);
          log('userModel: ${userModel.toString()}');
        } else {
          driver = await _loginRepo.loginRequest(data);
          log('driver: ${driver.toString()}');
        }
        SharedHandler.instance!
            .setData(SharedKeys().user, value: userModel.client!.toJson());
        SharedHandler.instance!
            .setData(SharedKeys().token, value: userModel.authToken);
        log('login token: ${userModel.authToken}');
        SharedHandler.instance!.setData(SharedKeys().isLogin, value: true);
        SharedHandler.instance!
            .setData(SharedKeys().isNotFirstTime, value: true);
        //SharedHandler.saveLoginData(_LoginModel);
        //SharedHandler.setData(_LoginModel);
        //log(' ${_loginModel.client!.accesxsToken!}');
        log('before pusher');
        NotificationCubit.instance.getPusherBeams();
        log('after pusher');
        if (userModel.client!.isValid!) {
          if (SharedHandler.instance!.getData(
                  key: SharedKeys().userType, valueType: ValueType.int) ==
              0) {
            AppRoutes.pushNamedNavigator(
                routeName: Routes.clientNavBar, replacementAll: true);
            clearData();
          } else {
            AppRoutes.pushNamedNavigator(
                routeName: Routes.driverNavBar, replacementAll: true);
            clearData();
          }
        } else {
          AppRoutes.pushNamedNavigator(
              routeName: Routes.emailVerification, replacement: true);
        }
        emit(LoginLoaded());
      }
    } catch (e) {
      log('login error :${e.toString()}');
      emit(LoginError());
    }
  }

  clearData() {
    phoneNumberController.clear();
    passwordController.clear();
  }
}
