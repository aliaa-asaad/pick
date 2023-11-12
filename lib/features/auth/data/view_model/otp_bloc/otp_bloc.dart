import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pick_up/core/user_model.dart';
import 'package:pick_up/core/validator.dart';
import 'package:pick_up/features/auth/data/model/otp_model.dart';
import 'package:pick_up/features/auth/data/model/otp/otp_repo.dart';
import 'package:pick_up/features/auth/data/view_model/bloc/auth_bloc.dart';
import 'package:pick_up/features/auth/data/view_model/login_bloc/login_bloc.dart';
import 'package:pick_up/features/auth/data/view_model/register_bloc/register_bloc.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OTPBloc extends Bloc<OTPEvent, OTPState> with Validations {
  OTPBloc() : super(OtpInitial()) {
    /*  on<OTPEvent>((event, emit) {
      // TODO: implement event handler
    }); */
    on<OTPPost>(_verifyCode);
  }
///////////instance//////////////

  static OTPBloc get instance =>
      BlocProvider.of(AppRoutes.navigatorState.currentContext!);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
/////////////////models////////////////
  late OTPModel _emailVerifiactionModel;
  final OTPRepo _otpRepo = OTPRepo();
  UserModel userModel=LoginBloc.instance.userModel.authToken!.isNotEmpty? LoginBloc.instance.userModel:RegisterBloc.instance.userModel;
////////////////////variables/////////////
  TextEditingController codeController1 = TextEditingController();
  String codeError1 = '';
  TextEditingController codeController2 = TextEditingController();
  String codeError2 = '';
  TextEditingController codeController3 = TextEditingController();
  String codeError3 = '';
  TextEditingController codeController4 = TextEditingController();
  String codeError4 = '';
  ///////////////////validation////////////////
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

  /////////////////////methods///////////////////
  _verifyCode(OTPEvent events, Emitter emit) async {
    emit(OTPLoading());
    try {
      Map<String, dynamic> data = {
        'phoneNumber': LoginBloc.instance.phoneNumberController.text.isNotEmpty
            ? LoginBloc.instance.phoneNumberController.text
            : RegisterBloc.instance.phoneNumberController.text,
        'otp': [
          codeController1.text,
          codeController2.text,
          codeController3.text,
          codeController4.text,
        ].join(),
        'type': SharedHandler.instance!
            .getData(key: SharedKeys().userType, valueType: ValueType.int)
      };
      log(data.toString());
      _emailVerifiactionModel = await _otpRepo.otpRequest(data);
      log('verified');
      log('isForgetPassword : ${AuthBloc.instance.isForgetPassword}');
      if (AuthBloc.instance.isForgetPassword == false) {
        log('model: ${userModel.client!.toJson()}');
        await SharedHandler.instance!
            .setData(SharedKeys().user, value: userModel.client!.toJson());
        await SharedHandler.instance!
            .setData(SharedKeys().isLogin, value: true);
        log('token: ${userModel.authToken}');
        await SharedHandler.instance!
            .setData(SharedKeys().token, value: userModel.authToken);
        await SharedHandler.instance!
            .setData(SharedKeys().isNotFirstTime, value: true);
      }

      if (AuthBloc.instance.isForgetPassword) {
        AppRoutes.pushNamedNavigator(routeName: Routes.newPassword);
      } else {
        if (SharedHandler.instance!.getData(
                key: SharedKeys().userType, valueType: ValueType.int) ==
            0) {
          AppRoutes.pushNamedNavigator(
              routeName: Routes.clientNavBar, replacementAll: true);
          RegisterBloc.instance.clearData();
        } else {
          AppRoutes.pushNamedNavigator(
              routeName: Routes.driverNavBar, replacementAll: true);
          RegisterBloc.instance.clearData();
        }
      }

      emit(OTPLoaded());
    } catch (e) {
      log('verify code error :${e.toString()}');
      emit(OTPError());
    }
  }
}
