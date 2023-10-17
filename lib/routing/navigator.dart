import 'package:flutter/material.dart';
import 'package:pick_up/features/auth/login/presentation/screens/forgot_password.dart';
import 'package:pick_up/features/auth/login/presentation/screens/login_screen.dart';
import 'package:pick_up/features/auth/login/presentation/screens/new_password.dart';
import 'package:pick_up/features/auth/register/presentation/screens/email_verification.dart';
import 'package:pick_up/features/auth/register/presentation/screens/sign_up_screen.dart';
import 'package:pick_up/features/home/presentation/screens/home_screen.dart';
import 'package:pick_up/features/nav_bar/nav_bar.dart';
import 'package:pick_up/features/on_boarding/view/screens/auth_screen.dart';
import 'package:pick_up/features/on_boarding/view/screens/check_screen.dart';
import 'package:pick_up/features/on_boarding/view/screens/on_boarding.dart';
import 'package:pick_up/features/order/presentation/screens/order_screen.dart';
import 'package:pick_up/features/payment/presentation/screens/payment.dart';
import 'package:pick_up/features/splash/view/splash_screen.dart';
import 'package:pick_up/routing/routes.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldState =
      GlobalKey<ScaffoldMessengerState>();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.onboarding:
        return AppRoutes.aniamtedNavigation(screen: const OnBoardingScreen());
      case Routes.auth:
        return AppRoutes.aniamtedNavigation(screen: const AuthScreen());
      case Routes.check:
        return AppRoutes.aniamtedNavigation(screen: CheckScreen());
      case Routes.login:
        return AppRoutes.aniamtedNavigation(screen: const LoginScreen());
      case Routes.forgetPassword:
        return AppRoutes.aniamtedNavigation(screen: const ForgotPassword());
      case Routes.emailVerification:
        return AppRoutes.aniamtedNavigation(
            screen: const EmailVerificationScreen());
      case Routes.newPassword:
        return AppRoutes.aniamtedNavigation(screen: const NewPassword());
      case Routes.signUp:
        return AppRoutes.aniamtedNavigation(screen: const SignUpScreen());
      case Routes.navBar:
        return AppRoutes.aniamtedNavigation(
            screen: const CustomNavigationBar());
      case Routes.home:
        return AppRoutes.aniamtedNavigation(screen: const HomeScreen());
      case Routes.order:
        return AppRoutes.aniamtedNavigation(screen: const OrderScreen());
      case Routes.payment:
        return AppRoutes.aniamtedNavigation(screen: const PaymentScreen());
      /* case Routes.orderData:
        return AppRoutes.aniamtedNavigation(screen: const OrderDataScreen());
      case Routes.orderImage:
        return AppRoutes.aniamtedNavigation(screen: const OrderImageScreen());
      case Routes.orderLocation:
        return AppRoutes.aniamtedNavigation(
            screen: const OrderLocationScreen());
      case Routes.orderConfirm:
        return AppRoutes.aniamtedNavigation(screen: const OrderConfirmScreen()); */
      default:
        return AppRoutes.aniamtedNavigation(
            screen: const Scaffold(
          body: Center(child: Text('Error')),
        ));
    }
  }

  static aniamtedNavigation({
    required Widget screen,
  }) {
    return PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => screen);
  }

  static pushNamedNavigator(
      {required String routeName,
      Object? arguments,
      bool replacement = false}) {
    if (replacement) {
      navigatorState.currentState!
          .pushReplacementNamed(routeName, arguments: arguments);
    } else {
      navigatorState.currentState!.pushNamed(routeName, arguments: arguments);
    }
  }
}
