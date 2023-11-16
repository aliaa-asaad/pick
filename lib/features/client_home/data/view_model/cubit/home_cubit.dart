import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pick_up/features/client_home/data/model/home_repo.dart';
import 'package:pick_up/features/client_home/data/model/home_slider_model.dart';
import 'package:pick_up/routing/navigator.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get instance =>
      BlocProvider.of(AppRoutes.navigatorState.currentContext!);
  List<Slider> imageSlider = [];
  HomeRepo homeRepo = HomeRepo();
  Future<void> getImageSlider() async {
    try {
      emit(HomeLoading());
      imageSlider = await homeRepo.getHomeSlider();
      log(imageSlider.toString());

      emit(HomeLoaded());
    } catch (e) {
      log(e.toString());
      emit(HomeError());
    }
  }
}
