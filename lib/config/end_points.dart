import 'package:pick_up/handlers/shared_handler.dart';

class ApiNames {
  static String baseUrl = 'https://pickupksa.com/Api/public/' 
       ;
  static const String loginEndPoint = 'api/login';
  static const String clientRegisterEndPoint = 'api/auth/client/register';
  static const String driverRegisterEndPoint = 'api/auth/driver/register';
  static const String emailVerificationEndPoint =
      'api/auth/client/email_verification';
  static const String forgetPasswordEndPoint = 'api/forgetPassword';
  static const String resetPasswordEndPoint = 'api/passwordReset';
  //static const String driverEmailVerification = 'api/auth/driver/email_verification';
  static const String imageSlider = 'api/slider';
  static const String orderEndPoint = 'api/createOrder';
  static const String orderImagesEndPoint = 'api/orderImages';
  static const String orderSubmitEndPoint = 'api/submitOrder';
  static const String editProfileEndPoint = 'api/auth/client/editeProfile';
  static const String editDriverProfileEndPoint =
      'api/auth/driver/editeProfile';
  static const String orderClientPendingEndPoint = 'api/order/submit/client';
  static const String orderClientAcceptedEndPoint = 'api/order/Accept/client';
  static const String orderClientCompletedEndPoint =
      'api/order/completed/client';
  static const String orderDetailsEndPoint = 'api/orders/';
  static const String orderStatusEndPoint = 'api/tracing-order';
  static const String orderDriverPendingEndPoint = 'api/order/submit/driver';
  static const String orderDriverAcceptedEndPoint = 'api/order/Accept/driver';
  static const String orderDriverCompletedEndPoint =
      'api/order/completed/driver';
  static const String pusherBeamsAuthEndPoint = 'api/pusher/beams-auth';
  static const String notificationDriverEndPoint = 'api/driver/notification';
  static const String notificationClientEndPoint = 'api/client/notification';
  static const String paymentEndPoint = 'api/create-charge';
  static const String paymentMethodsEGEndPoint = 'api/paymentMethods';
  static const String chatDriverEndPoint = 'api/driver/chat';
  static const String chatClientEndPoint = 'api/client/chat';
  static const String deleteAccountDriverEndPoint =
      'api/auth/driver/deleteAccount';
  static const String deleteAccountClientEndPoint =
      'api/auth/client/deleteAccount';
  static const String mapApiKey = 'AIzaSyChp0nLB3HQYzXyCqmHSK3-N2c316gdzD8';
  static const String instanceID = '01aef67e-5a58-4f21-931f-65f3485464cc';
}
