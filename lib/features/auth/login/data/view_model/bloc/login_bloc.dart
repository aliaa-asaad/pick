import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pick_up/core/user_model.dart';
import 'package:pick_up/core/validator.dart';
import 'package:pick_up/features/auth/login/data/model/login_repo.dart';
import 'package:pick_up/features/auth/login/data/view_model/bloc/login_event.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with Validations {
  final LoginRepo _loginRepo = LoginRepo();
  late UserModel _userModel;

  LoginBloc() : super(LoginInitial()) {
    on<LoginClick>(login);
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
  TextEditingController phoneController = TextEditingController();
  String phoneError = '';

  //===========================
  TextEditingController password = TextEditingController();
  String passwordError = '';

  bool _validate() {
    phoneError = isValidPhoneBloc(phoneController.text);
    passwordError = isValidPasswordBloc(password.text);
    return phoneError.isEmpty && passwordError.isEmpty;
  }

  login(LoginEvent events, Emitter emit) async {
    emit(LoginLoading());
    if (_validate()) {
      Map<String, dynamic> data = {
        "phoneNumber": phoneController.text,
        "password": password.text,
        "type": SharedHandler.instance!
            .getData(key: SharedKeys().userType, valueType: ValueType.int)
      };
      _userModel = await _loginRepo.loginRequest(data);
      SharedHandler.instance!
          .setData(SharedKeys().user, value: _userModel.client!.toJson());
      SharedHandler.instance!.setData(SharedKeys().isLogin, value: true);
      SharedHandler.instance!.setData(SharedKeys().isFirstTime, value: true);
      //SharedHandler.saveLoginData(_authModel);
      //SharedHandler.setData(_authModel);
      //log(' ${_loginModel.client!.accessToken!}');
      _userModel.client!.isValid!
          ? AppRoutes.pushNamedNavigator(
              routeName: Routes.navBar, replacement: true)
          : AppRoutes.pushNamedNavigator(
              routeName: Routes.emailVerification, replacement: true);
      emit(LoginLoaded());
    } else {
      emit(LoginError());
    }
  }
}
