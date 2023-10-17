import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pick_up/features/auth/login/data/view_model/bloc/login_bloc.dart';
import 'package:pick_up/features/auth/register/data/view_model/bloc/register_bloc.dart';
import 'package:pick_up/features/home/data/view_model/cubit/home_cubit.dart';

class Blocs {
  static List<BlocProvider> blocs = [
    BlocProvider(
      create: (context) => RegisterBloc(),
    ),
    BlocProvider(
      create: (context) => HomeCubit()..getImageSlider(),
    ),
    BlocProvider(
      create: (context) => LoginBloc(),
    ),
  ];
}
