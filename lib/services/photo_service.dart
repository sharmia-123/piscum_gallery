import 'dart:convert';
import 'package:picsum_gallery/model/photo_model.dart';
import 'package:http/http.dart' as http;

class PhotoService {
  Future<List<PhotoModel>> fetchPhotos() async {
    final response = await http.get(
      Uri.parse('https://picsum.photos/v2/list'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data
          .map((json) => PhotoModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}