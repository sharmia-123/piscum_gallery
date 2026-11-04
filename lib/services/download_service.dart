import 'package:gal/gal.dart';
import 'package:http/http.dart' as http;

class DownloadService {
  Future<void> downloadImage(String imageUrl, String imageId) async {
    bool hasAccess = await Gal.hasAccess();

    if (!hasAccess) {
      hasAccess = await Gal.requestAccess();
    }

    if (!hasAccess) {
      throw Exception('Gallery permission denied');
    }

    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      await Gal.putImageBytes(
        response.bodyBytes,
        name: 'photo_$imageId',
      );
    } else {
      throw Exception('Download failed');
    }
  }
}