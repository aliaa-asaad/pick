import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/config/end_points.dart';
import 'package:pick_up/features/auth/data/view_model/bloc/auth_bloc.dart';
import 'package:pick_up/features/client_home/data/view_model/cubit/home_cubit.dart';
import 'package:pick_up/features/my_order/data/view_model/cubit/my_order_cubit.dart';
import 'package:pick_up/features/my_order/presentation/screens/driver_order_status_screen.dart';
import 'package:pick_up/features/notification/data/view_model/cubit/notification_cubit.dart';
import 'package:pick_up/features/on_boarding/view/screens/on_boarding.dart';
import 'package:pick_up/features/order/data/view_model/bloc/order_bloc.dart';
import 'package:pick_up/features/profile/data/view_model/bloc/profile_bloc.dart';
import 'package:pick_up/features/splash/view/splash_screen.dart';
import 'package:pick_up/handlers/localization.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/network/web_services.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/utilities/theme.dart';
import 'package:pusher_beams/pusher_beams.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await PusherBeams.instance.start(ApiNames.instanceID);
  await PusherBeams.instance.setDeviceInterests(['driver']);
  //add or remove interests
  PusherBeams.instance
      .onInterestChanges((interests) => log('interests :$interests'));
  //push notification is received while the app is in the foreground
  PusherBeams.instance.onMessageReceivedInTheForeground(
      (notification) => log('notifications: $notification'));
  final BeamsAuthProvider beamsAuthProvider = BeamsAuthProvider()
    ..authUrl = 'https://pickupksa.com/api/public/api/pusher/beams-auth'
    ..headers = {'Content-Type': 'application/json'}
    ..queryParams = {'user_id': '1'}
    ..credentials = 'omit';
  /* await PusherBeams.instance.addDeviceInterest('bananas');
await PusherBeams.instance.removeDeviceInterest('bananas');
await PusherBeams.instance.clearDeviceInterests(); */
  await SharedHandler.init();
  Network.init();
  runApp(
    ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit() /* ..getImageSlider() */,
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
        BlocProvider(
          create: (context) => NotificationCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider(
          create: (context) => MyOrderCubit(),
        )
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
        localizationsDelegates: const [
          AppLocale.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale("ar")],
        locale: const Locale("ar"),
        home: const SplashScreen(),
      ),
    );
  }
}
