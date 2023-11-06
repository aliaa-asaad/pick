import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pick_up/core/user_model.dart';
import 'package:pick_up/features/notification/data/model/notification_model.dart';
import 'package:pick_up/features/notification/data/model/notification_repo.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';
import 'package:pusher_beams/pusher_beams.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  late UserModel _userModel;
  late NotificationModel notificationModel;
  NotificationRepo notificationRepo = NotificationRepo();
  static NotificationCubit get instance =>
      BlocProvider.of(AppRoutes.navigatorState.currentContext!);
  Future<void> getPusherBeams() async {
    try {
      emit(NotificationLoading());

      log("id :${SharedHandler.instance!.getData(key: SharedKeys().user, valueType: ValueType.map)['id']}");
      final BeamsAuthProvider provider = BeamsAuthProvider()
        ..authUrl = 'https://pickupksa.com/api/public/api/pusher/beams-auth'
        ..headers = {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${SharedHandler.instance!.getData(key: SharedKeys().token, valueType: ValueType.string)}'
        }
        ..queryParams = {
          'user_id': SharedHandler.instance!
              .getData(key: SharedKeys().user, valueType: ValueType.map)['id']
              .toString()
        }
        ..credentials = 'omit';

      await PusherBeams.instance.setUserId(
          '3',
          provider,
          (error) => {
                if (error != null) {log('error:$error')}
                // Success! Do something...
              });
      log('notificationModel: ${PusherBeams.instance.getDeviceInterests()}');

      emit(NotificationLoaded(/* imageSlider */));
    } catch (e) {
      log('notification cubit error:$e');
      emit(NotificationError());
    }
  }
}
