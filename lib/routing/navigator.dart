import 'package:flutter/material.dart';
import 'package:pick_up/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:pick_up/features/auth/presentation/screens/login_screen.dart';
import 'package:pick_up/features/auth/presentation/screens/new_password_screen.dart';
import 'package:pick_up/features/auth/presentation/screens/otp_screen.dart';
import 'package:pick_up/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:pick_up/features/client_home/presentation/screens/home_screen.dart';
import 'package:pick_up/features/my_order/data/model/all_orders_model.dart';
import 'package:pick_up/features/my_order/presentation/screens/driver_order_status_screen.dart';
import 'package:pick_up/features/my_order/presentation/screens/order_details_screen.dart';
import 'package:pick_up/features/nav_bar/client_nav_bar.dart';
import 'package:pick_up/features/nav_bar/driver_nav_bar.dart';
import 'package:pick_up/features/notification/presentation/screens/notifications_screen.dart';
import 'package:pick_up/features/on_boarding/view/screens/auth_screen.dart';
import 'package:pick_up/features/on_boarding/view/screens/check_country_screen.dart';
import 'package:pick_up/features/on_boarding/view/screens/check_screen.dart';
import 'package:pick_up/features/on_boarding/view/screens/on_boarding.dart';
import 'package:pick_up/features/order/presentation/screens/order_screen.dart';
import 'package:pick_up/features/payment/presentation/screens/eg_payment_code_screen.dart';
import 'package:pick_up/features/payment/presentation/screens/eg_payment_methods_screen.dart';
import 'package:pick_up/features/profile/presentation/screens/about_screen.dart';
import 'package:pick_up/features/profile/presentation/screens/bills_screen.dart';
import 'package:pick_up/features/profile/presentation/screens/call_center_screen.dart';
import 'package:pick_up/features/profile/presentation/screens/edit_profile.dart';
import 'package:pick_up/features/profile/presentation/screens/localization_screen.dart';
import 'package:pick_up/features/profile/presentation/screens/policy_screen.dart';
import 'package:pick_up/features/profile/presentation/screens/profile_screen.dart';
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
        return AppRoutes.aniamtedNavigation(screen: const CheckScreen());
      case Routes.checkCountry:
        return AppRoutes.aniamtedNavigation(screen: const CheckCountryScreen());
      case Routes.login:
        return AppRoutes.aniamtedNavigation(screen: const LoginScreen());
      case Routes.forgetPassword:
        return AppRoutes.aniamtedNavigation(screen: const ForgotPassword());
      case Routes.emailVerification:
        return AppRoutes.aniamtedNavigation(screen: const OTPScreen());
      case Routes.newPassword:
        return AppRoutes.aniamtedNavigation(screen: const NewPassword());
      case Routes.signUp:
        return AppRoutes.aniamtedNavigation(screen: const SignUpScreen());
      case Routes.clientNavBar:
        return AppRoutes.aniamtedNavigation(
            screen: const ClientNavigationBar());
      case Routes.driverNavBar:
        return AppRoutes.aniamtedNavigation(
            screen: const DriverNavigationBar());
      case Routes.home:
        return AppRoutes.aniamtedNavigation(screen: const HomeScreen());
      case Routes.order:
        return AppRoutes.aniamtedNavigation(screen: const OrderScreen());
      case Routes.orderDetails:
        return MaterialPageRoute(
          builder: (context) => OrderDetailsScreen(
            orderId: settings.arguments as int,
          ),
        );
      case Routes.driverOrderStatus:
        return AppRoutes.aniamtedNavigation(
            screen: DriverOrderStatusScreen(
                orderModel: settings.arguments as Orders));
      case Routes.notification:
        return AppRoutes.aniamtedNavigation(screen: const NotificationScreen());

      case Routes.egPaymentMethods:
        return AppRoutes.aniamtedNavigation(
            screen: const EGPaymentMethodsScreen());
      case Routes.egPaymentCode:
        return AppRoutes.aniamtedNavigation(
            screen: const EGPAymentCodeScreen());
      case Routes.editProfile:
        return AppRoutes.aniamtedNavigation(screen: const EditProfileScreen());
      case Routes.bills:
        return AppRoutes.aniamtedNavigation(screen: const BillsScreen());
      case Routes.about:
        return AppRoutes.aniamtedNavigation(screen: const AboutScreen());
      case Routes.localization:
        return AppRoutes.aniamtedNavigation(screen: const LocalizationScreen());
      case Routes.callCenter:
        return AppRoutes.aniamtedNavigation(screen: const CallCenterScreen());
      case Routes.policy:
        return AppRoutes.aniamtedNavigation(screen: const PolicyScreen());
      case Routes.profile:
        return AppRoutes.aniamtedNavigation(screen: const ProfileScreen());
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
            body: Center(child: Text('No screen')),
          ),
        );
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
      bool replacement = false,
      bool replacementAll = false}) {
    if (replacement == true) {
      navigatorState.currentState!
          .pushReplacementNamed(routeName, arguments: arguments);
    } else if (replacementAll == true) {
      navigatorState.currentState!.pushNamedAndRemoveUntil(
          routeName, (route) => false,
          arguments: arguments);
    } else {
      navigatorState.currentState!.pushNamed(routeName, arguments: arguments);
    }
  }
}
