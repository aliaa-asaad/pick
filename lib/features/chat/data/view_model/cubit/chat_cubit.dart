import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pick_up/features/chat/data/model/chat_model.dart';
import 'package:pick_up/features/chat/data/model/chat_repo.dart';
import 'package:pick_up/routing/navigator.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  late ChatModel chatModel = ChatModel();
  ChatRepo chatRepo = ChatRepo();
  static ChatCubit get instance =>
      BlocProvider.of(AppRoutes.navigatorState.currentContext!);
  getChats() async {
    try {
      emit(ChatLoading());
      chatModel = await chatRepo.getNotifications();
      log('chatmodel: ${chatModel.toString()}');
      emit(ChatLoaded());
    } catch (e) {
      log('get chat cubit error:$e');
      emit(ChatError());
    }
  }
}
