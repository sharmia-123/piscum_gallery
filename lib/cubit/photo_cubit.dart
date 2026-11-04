import 'package:bloc/bloc.dart';
import 'package:picsum_gallery/model/photo_model.dart';
import 'package:picsum_gallery/services/photo_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {

  // Passing PhotoService
  final PhotoService photoService;

  // Favourite photos list
  final List<PhotoModel> favouritePhotos = [];

  PhotoCubit(this.photoService) : super(PhotoInitial());

  Future<void> fetchPhotos() async {
    emit(PhotoLoading());

    try {
      final photos = await photoService.fetchPhotos();

      emit(PhotoLoaded(photos));

      // Load saved favourites after fetching photos
      await loadFavourites();

    } catch (e) {
      emit(PhotoError('Failed to load photos'));
    }
  }

  // Load saved favourite photos
  Future<void> loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();

    final favouriteIds = prefs.getStringList('favourites') ?? [];

    final currentState = state;

    if (currentState is PhotoLoaded) {
      favouritePhotos.clear();

      favouritePhotos.addAll(
        currentState.photos.where(
          (photo) => favouriteIds.contains(photo.id),
        ),
      );
    }
  }
  // toggle
  Future<void> toggleFavourite(PhotoModel photo) async {
  final prefs = await SharedPreferences.getInstance();

  final isAlreadyFavourite = favouritePhotos.any(
    (item) => item.id == photo.id,
  );

  if (isAlreadyFavourite) {
    favouritePhotos.removeWhere((item) => item.id == photo.id);
  } else {
    favouritePhotos.add(photo);
  }

  final favouriteIds = favouritePhotos
      .map((item) => item.id)
      .toList();

  await prefs.setStringList('favourites', favouriteIds);
  if (state is PhotoLoaded) {
    emit(PhotoLoaded((state as PhotoLoaded).photos));
  }
}
bool isFavourite(PhotoModel photo) {
  return favouritePhotos.any((item) => item.id == photo.id);
}
}
