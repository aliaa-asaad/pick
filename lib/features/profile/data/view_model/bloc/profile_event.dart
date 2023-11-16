part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class EditProfile extends ProfileEvent {}
class UploadImage extends ProfileEvent {}
class Logout extends ProfileEvent {}
class ChangeLanguage extends ProfileEvent {}
class ChangePassword extends ProfileEvent {}
class DeleteAccount extends ProfileEvent {}
