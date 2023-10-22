import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pick_up/features/auth/data/view_model/bloc/auth_bloc.dart';
import 'package:pick_up/features/home/data/view_model/cubit/home_cubit.dart';

class Blocs {
  static List<BlocProvider> blocs = [
   
    BlocProvider(
      create: (context) => HomeCubit()..getImageSlider(),
    ),
    BlocProvider(
      create: (context) => AuthBloc(),
    ),
  ];
}
