import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pick_up/core/driver_model.dart';
import 'package:pick_up/core/user_model.dart';
import 'package:pick_up/features/profile/data/model/delete_account_model.dart';
import 'package:pick_up/features/profile/data/model/profile_repo.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<EditProfile>(_editProfile);
    on<UploadImage>(_uploadImage);
    on<DeleteAccount>(_deleteAccount);
    on<ProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
  ///////////instance//////////////

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static ProfileBloc get instance =>
      BlocProvider.of(AppRoutes.navigatorState.currentContext!);

  /////////////////models////////////////

  UserModel _userModel = UserModel();
  DriverModel _driverModel = DriverModel();
  final ProfileRepo _profileRepo = ProfileRepo();
  DeleteAccountModel _deleteAccountModel = DeleteAccountModel();

  /////////////////variables////////////////
  Client client = Client.fromJson(SharedHandler.instance!
      .getData(key: SharedKeys().user, valueType: ValueType.map));

  Driver driver = Driver.fromJson(SharedHandler.instance!
      .getData(key: SharedKeys().driver, valueType: ValueType.map));
  TextEditingController fullNameController = TextEditingController(
      text: SharedHandler.instance!.getData(
                  key: SharedKeys().userType, valueType: ValueType.int) ==
              0
          ? SharedHandler.instance!.getData(
              key: SharedKeys().user, valueType: ValueType.map)['fullName']
          : SharedHandler.instance!.getData(
              key: SharedKeys().driver, valueType: ValueType.map)['fullName']);

  TextEditingController phoneNumberController = TextEditingController(
      text: SharedHandler.instance!.getData(
                  key: SharedKeys().userType, valueType: ValueType.int) ==
              0
          ? SharedHandler.instance!.getData(
              key: SharedKeys().user, valueType: ValueType.map)['phoneNumber']
          : SharedHandler.instance!.getData(
              key: SharedKeys().driver,
              valueType: ValueType.map)['phoneNumber']);

  TextEditingController emailController = TextEditingController(
      text: SharedHandler.instance!.getData(
                  key: SharedKeys().userType, valueType: ValueType.int) ==
              0
          ? SharedHandler.instance!.getData(
              key: SharedKeys().user, valueType: ValueType.map)['email']
          : SharedHandler.instance!.getData(
              key: SharedKeys().driver, valueType: ValueType.map)['email']);

  TextEditingController nationalIdController = TextEditingController(
      text: SharedHandler.instance!.getData(
          key: SharedKeys().driver, valueType: ValueType.map)['nationalId']);
  TextEditingController carTypeController = TextEditingController(
      text: SharedHandler.instance!.getData(
          key: SharedKeys().driver, valueType: ValueType.map)['carType']=='0'?'بيك أب':SharedHandler.instance!.getData(
          key: SharedKeys().driver, valueType: ValueType.map)['carType']=='1'?'دينة شبك':'دينة');
  TextEditingController carBrandController = TextEditingController(
      text: SharedHandler.instance!.getData(
          key: SharedKeys().driver, valueType: ValueType.map)['carBrand']);
  TextEditingController carModelController = TextEditingController(
      text: SharedHandler.instance!.getData(
          key: SharedKeys().driver, valueType: ValueType.map)['carModel']);
  TextEditingController carNumberController = TextEditingController(
      text: SharedHandler.instance!.getData(
          key: SharedKeys().driver, valueType: ValueType.map)['carNumber']);
  TextEditingController isActiveController = TextEditingController(
      text: SharedHandler.instance!.getData(
          key: SharedKeys().driver, valueType: ValueType.map)['isActive']);

  File? image;

  _editProfile(ProfileEvent events, Emitter emit) async {
    emit(ProfileLoading());
    try {
      Map<String, dynamic> data = SharedHandler.instance!.getData(
                  key: SharedKeys().userType, valueType: ValueType.int) ==
              0
          ? {
              "fullName": fullNameController.text,
            }
          : {
              "fullName": fullNameController.text,
              //   "nationalId": nationalIdController.text,
              "carType": carTypeController.text,
              "carBrand": carBrandController.text,
              "carModel": carModelController.text,
              "carNumber": carNumberController.text,
            };
      log('data: $data');
      if (SharedHandler.instance!
              .getData(key: SharedKeys().userType, valueType: ValueType.int) ==
          0) {
        _userModel = await _profileRepo.editProfileRequest(data);
        SharedHandler.instance!
            .setData(SharedKeys().user, value: _userModel.client!.toJson());
        await SharedHandler.instance!
            .setData(SharedKeys().token, value: _userModel.authToken);
      } else {
        _driverModel = await _profileRepo.editProfileRequest(data);
        SharedHandler.instance!
            .setData(SharedKeys().driver, value: _driverModel.client!.toJson());
        await SharedHandler.instance!
            .setData(SharedKeys().token, value: _driverModel.authToken);
      }

      //  log('login token: ${_userModel.authToken}');
      //SharedHandler.saveLoginData(_authModel);
      //SharedHandler.setData(_authModel);
      //log(' ${_loginModel.client!.accesxsToken!}');
      log('edit profile success');
      emit(ProfileLoaded());
    } catch (e) {
      log('edit profile error :${e.toString()}');
      emit(ProfileError());
    }
  }

  _uploadImage(ProfileEvent events, Emitter emit) async {
    emit(ProfileLoading());
    try {
      Map<String, dynamic> data = {
        'image': MultipartFile.fromFileSync(
          image!.path,
          filename: image!.path.split("/").last,
        )
      };

      log('data: $data');
      if (SharedHandler.instance!
              .getData(key: SharedKeys().userType, valueType: ValueType.int) ==
          0) {
        _userModel =
            await _profileRepo.uploadImageRequest(FormData.fromMap(data));
        SharedHandler.instance!
            .setData(SharedKeys().user, value: _userModel.client!.toJson());
        await SharedHandler.instance!
            .setData(SharedKeys().token, value: _userModel.authToken);
      } else {
        _driverModel =
            await _profileRepo.uploadImageRequest(FormData.fromMap(data));
        SharedHandler.instance!
            .setData(SharedKeys().driver, value: _driverModel.client!.toJson());
        await SharedHandler.instance!
            .setData(SharedKeys().token, value: _driverModel.authToken);
      }

      //  log('login token: ${_userModel.authToken}');
      //SharedHandler.saveLoginData(_authModel);
      //SharedHandler.setData(_authModel);
      //log(' ${_loginModel.client!.accesxsToken!}');
      log('image success');
      emit(ProfileLoaded());
    } catch (e) {
      log('image error :${e.toString()}');
      emit(ProfileError());
    }
  }

  _deleteAccount(ProfileEvent events, Emitter emit) async {
    emit(ProfileLoading());
    try {
      _deleteAccountModel = await _profileRepo.deleteProfileRequest();

      SharedHandler.instance!.clear(keys: [
        SharedKeys().driver,
        SharedKeys().user,
        SharedKeys().isLogin,
        SharedKeys().token,
        SharedKeys().userType,
      ]);
      AppRoutes.pushNamedNavigator(
          routeName: Routes.check, replacementAll: true);
      //  log('login token: ${_userModel.authToken}');
      //SharedHandler.saveLoginData(_authModel);
      //SharedHandler.setData(_authModel);
      //log(' ${_loginModel.client!.accesxsToken!}');
      log('delete profile success');
      emit(ProfileLoaded());
    } catch (e) {
      log('delete profile error :${e.toString()}');
      emit(ProfileError());
    }
  }
}
