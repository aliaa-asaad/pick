import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pick_up/core/user_model.dart';
import 'package:pick_up/features/profile/data/model/profile_repo.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/routing/navigator.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<EditProfile>(_editProfile);
    on<UploadImage>(_uploadImage);
    on<ProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
  static ProfileBloc get instance =>
      BlocProvider.of(AppRoutes.navigatorState.currentContext!);
  UserModel _userModel = UserModel();
  final ProfileRepo _profileRepo = ProfileRepo();
  Client client = Client.fromJson(SharedHandler.instance!
      .getData(key: SharedKeys().user, valueType: ValueType.map));
  TextEditingController fullNameController = TextEditingController(
      text: SharedHandler.instance!.getData(
          key: SharedKeys().user, valueType: ValueType.map)['fullName']);

  TextEditingController phoneNumberController = TextEditingController(
      text: SharedHandler.instance!.getData(
          key: SharedKeys().user, valueType: ValueType.map)['phoneNumber']);
  TextEditingController emailController = TextEditingController(
      text: SharedHandler.instance!
          .getData(key: SharedKeys().user, valueType: ValueType.map)['email']);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? image;

  _editProfile(ProfileEvent events, Emitter emit) async {
    emit(ProfileLoading());
    try {
      Map<String, dynamic> data = {
        "fullName": fullNameController.text,
      };
      log('data: $data');
      _userModel = await _profileRepo.editProfileRequest(data);
      SharedHandler.instance!
          .setData(SharedKeys().user, value: _userModel.client!.toJson());
          await SharedHandler.instance!
            .setData(SharedKeys().token, value: _userModel.authToken);
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
      _userModel = await _profileRepo.uploadImageRequest(FormData.fromMap(data));
      SharedHandler.instance!
          .setData(SharedKeys().user, value: _userModel.client!.toJson());
          await SharedHandler.instance!
            .setData(SharedKeys().token, value: _userModel.authToken);
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
}
