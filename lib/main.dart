import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/core/blocs.dart';
import 'package:pick_up/features/auth/register/presentation/screens/email_verification.dart';
import 'package:pick_up/features/auth/register/presentation/screens/sign_up_screen.dart';
import 'package:pick_up/features/nav_bar/nav_bar.dart';
import 'package:pick_up/features/on_boarding/view/screens/auth_screen.dart';
import 'package:pick_up/features/on_boarding/view/screens/check_screen.dart';
import 'package:pick_up/features/on_boarding/view/screens/on_boarding.dart';
import 'package:pick_up/features/auth/login/data/view_model/bloc/login_bloc.dart';
import 'package:pick_up/features/auth/register/data/view_model/bloc/register_bloc.dart';
import 'package:pick_up/features/home/data/view_model/cubit/home_cubit.dart';
import 'package:pick_up/features/splash/view/splash_screen.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/network/web_services.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/study/study_home.dart';
import 'package:pick_up/utilities/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedHandler.init();
  await Network.init();
  runApp(ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => HomeCubit() /* ..getImageSlider() */,
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pick Up',
        theme: AppTheme().lightTheme,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        //initialRoute: Routes.onboarding,
        navigatorKey: AppRoutes.navigatorState,
        navigatorObservers: [AppRoutes.routeObserver],
        scaffoldMessengerKey: AppRoutes.scaffoldState,
        /* localizationsDelegates: const [
            //AppLocale.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [ Locale("ar")],
          locale: Locale("ar"), */
        home: const EmailVerificationScreen(),
      ),
    );
  }
}
