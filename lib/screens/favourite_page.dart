import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:picsum_gallery/cubit/photo_cubit.dart';
import 'package:picsum_gallery/screens/photo_detail_page.dart';
import 'package:picsum_gallery/theme/app_colors.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: BlocBuilder<PhotoCubit, PhotoState>(
        builder: (context, state) {
          final favourites =
              context.watch<PhotoCubit>().favouritePhotos;

          if (favourites.isEmpty) {
            return const Center(
              child: Text('No favourite photos yet'),
            );
          }

          return MasonryGridView.count(
            padding: const EdgeInsets.all(20),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            itemCount: favourites.length,
            itemBuilder: (context, index) {
              final photo = favourites[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PhotoDetailPage(photo: photo),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    photo.downloadUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: index.isEven ? 180 : 230,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
