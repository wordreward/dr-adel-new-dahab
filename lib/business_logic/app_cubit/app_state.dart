part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}
class GenderSwitch extends AppState {}
class ImageLoaded extends AppState {}
class ImageError extends AppState {}
class LoginLoading extends AppState {}
class LoginSuccess extends AppState {}
class UserNotExist extends AppState {}
class LoginError extends AppState {
  final String message;

  LoginError(this.message);
}
class SignupLoading extends AppState {}
class SignupSuccess extends AppState {}
class SignupError extends AppState {
  final String message;

  SignupError(this.message);
}
class UpdateLoading extends AppState {}
class UpdateSuccess extends AppState {}
class UpdateError extends AppState {
  final String message;

  UpdateError(this.message);
}
class UserDataLoading extends AppState {}
class UserDataSuccess extends AppState {}
class UserDataError extends AppState {
  final String message;

  UserDataError(this.message);
}
class TransferLoading extends AppState {}
class TransferSuccess extends AppState {}
class TransferError extends AppState {
  final String message;

  TransferError(this.message);
}
class BookingLoading extends AppState {}
class BookingSuccess extends AppState {}
class BookingError extends AppState {
  final String message;

  BookingError(this.message);
}
class DeleteUserLoading extends AppState {}
class DeleteUserSuccess extends AppState {}
class DeleteUserError extends AppState {
  final String message;

  DeleteUserError(this.message);
}
class GetTransLoading extends AppState {}
class GetTransSuccess extends AppState {}
class GetTransError extends AppState {
  final String message;

  GetTransError(this.message);
}
class GetAboutLoading extends AppState {}
class GetAboutSuccess extends AppState {}
class GetAboutError extends AppState {
  final String message;

  GetAboutError(this.message);
}
class NotificationsLoading extends AppState {}
class NotificationsSuccess extends AppState {}
class NotificationsError extends AppState {
  final String message;

  NotificationsError(this.message);
}
class ConnectGLoading extends AppState {}
class ConnectGSuccess extends AppState {}
class ConnectGError extends AppState {
  final String message;

  ConnectGError(this.message);
}
class ReviewFBLoading extends AppState {}
class ReviewFBSuccess extends AppState {}
class ReviewFBError extends AppState {
  final String message;
  ReviewFBError(this.message);
}
class CheckInFBLoading extends AppState {}
class CheckInFBSuccess extends AppState {}
class CheckInFBError extends AppState {
  final String message;

  CheckInFBError(this.message);
}
class ReviewGLoading extends AppState {}
class ReviewGSuccess extends AppState {}
class ReviewGError extends AppState {
  final String message;

  ReviewGError(this.message);
}


