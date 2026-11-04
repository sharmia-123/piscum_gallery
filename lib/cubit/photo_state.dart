part of 'photo_cubit.dart';

sealed class PhotoState {}

final class PhotoInitial extends PhotoState {}
final class PhotoLoading extends PhotoState {}

final class PhotoLoaded extends PhotoState {
  final List<PhotoModel> photos;

  PhotoLoaded(this.photos);
}

final class PhotoError extends PhotoState {
  final String message;

  PhotoError(this.message);
}