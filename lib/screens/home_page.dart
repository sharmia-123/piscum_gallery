import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picsum_gallery/cubit/photo_cubit.dart';
import 'package:picsum_gallery/screens/favourite_page.dart';
import 'package:picsum_gallery/screens/photo_detail_page.dart';
import 'package:picsum_gallery/theme/app_colors.dart';
import 'package:picsum_gallery/utils/my_textfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 20.0,
        ),
        child: Column(
          children: [
            Text(
              'Photography is the beauty of life, captured.',
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 30,
                color: black,
              ),
            ),

            const SizedBox(height: 10.0),

            MyTextfield(
              textfieldtext: 'search for photo',
            ),

            const SizedBox(height: 15.0),

            Expanded(
              child: BlocBuilder<PhotoCubit, PhotoState>(
                builder: (context, state) {
                  if (state is PhotoLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is PhotoError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }

                  if (state is PhotoLoaded) {
                    final photos = state.photos;

                    return MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      itemCount: photos.length,
                      itemBuilder: (context, index) {
                        final photo = photos[index];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                // Photo image
                                GestureDetector(
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
                                      width: double.infinity,
                                      height: index.isEven ? 180 : 230,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Favourite button
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: CircleAvatar(
                                    backgroundColor: background,
                                    child: IconButton(
                                      onPressed: () {
                                        context
                                            .read<PhotoCubit>()
                                            .toggleFavourite(photo);
                                      },
                                      icon: Icon(
                                        context
                                                .watch<PhotoCubit>()
                                                .isFavourite(photo)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 5),

                            Text(photo.author),
                          ],
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),

      // Favourite page navigation
      floatingActionButton: FloatingActionButton(
        backgroundColor: black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FavouritePage(),
            ),
          );
        },
        child: Icon(
          Icons.favorite_border_outlined,
          color: white,
          size: 25,
        ),
      ),
    );
  }
}
