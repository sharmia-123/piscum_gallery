import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picsum_gallery/cubit/photo_cubit.dart';
import 'package:picsum_gallery/screens/home_page.dart';
import 'package:picsum_gallery/services/photo_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
Widget build(BuildContext context) {
  return BlocProvider(
    create: (context) =>
    PhotoCubit(PhotoService())..fetchPhotos(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      ),
    );
  }
}
