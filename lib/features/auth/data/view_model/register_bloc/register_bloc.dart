import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pick_up/core/user_model.dart';
import 'package:pick_up/core/validator.dart';
import 'package:pick_up/features/auth/data/model/register/register_repo.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> with Validations {
  RegisterBloc() : super(RegisterInitial()) {
    /* on<RegisterEvent>((event, emit) {
      // TODO: implement event handler
    }); */

    on<RegisterPost>(_register);
  }
  ///////////instance//////////////
  static RegisterBloc get instance =>
      BlocProvider.of(AppRoutes.navigatorState.currentContext!);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  /////////////////models////////////////
  final RegisterRepo _registerRepo = RegisterRepo();
  
    UserModel userModel = UserModel();
  Driver driver = Driver();

////////////////////variables/////////////
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
  ///////////////////validation////////////////
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

  //////////////////methods///////////////////

  _register(RegisterEvent events, Emitter emit) async {
    emit(RegisterLoading());
    try {
      if (_registerValidation()) {
        Map<String, dynamic> data = {
          'fullName': fullNameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'phoneNumber': phoneNumberController.text,
        };
        userModel = await _registerRepo.registerRequest(data);
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
      }
    } catch (e) {
      log('register error :${e.toString()}');
      emit(RegisterError());
    }
  }
  clearData() {
    fullNameController.clear();
    phoneNumberController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    emailController.clear();
    
  }
}
