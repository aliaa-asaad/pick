import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pick_up/features/home/data/model/home_repo.dart';
import 'package:pick_up/features/home/data/model/image_slider_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  ImageSlider imageSlider = ImageSlider();
  HomeRepo homeRepo = HomeRepo();
  Future<void> getImageSlider() async {
    try {
      emit(HomeLoading());
      imageSlider = await homeRepo.getImageSlider();
      log(imageSlider.toString());

      emit(HomeLoaded(imageSlider));
    } catch (e) {
      log(e.toString());
      emit(HomeError());
    }
  }
}
