import 'package:flutter/material.dart';
import 'package:picsum_gallery/model/photo_model.dart';
import 'package:picsum_gallery/screens/favourite_page.dart';
import 'package:picsum_gallery/services/download_service.dart';
import 'package:picsum_gallery/theme/app_colors.dart';

class PhotoDetailPage extends StatefulWidget {
  final PhotoModel photo;

  const PhotoDetailPage({
    super.key,
    required this.photo,
  });

  @override
  State<PhotoDetailPage> createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  final DownloadService downloadService = DownloadService();

  Future<void> downloadPhoto() async {
    try {
      await downloadService.downloadImage(
        widget.photo.downloadUrl,
        widget.photo.id,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image saved successfully!'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not save image: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          Image.network(
            widget.photo.downloadUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 50, 
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black45,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new, color: white, size: 18), 
                  ),
                ),

                CircleAvatar(
                  backgroundColor: white,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavouritePage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.favorite_border_outlined,
                      color: black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20.0, bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end, 
                  children: [
                    Text(
                      'By ${widget.photo.author}',
                      style: const TextStyle(color: white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Photo ID: ${widget.photo.id}',
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Size: ${widget.photo.width} × ${widget.photo.height} px',
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Source: ${widget.photo.url}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, 
                      style: const TextStyle(color: Colors.blueAccent, fontSize: 14, decoration: TextDecoration.underline),
                    ),
                    const SizedBox(height: 20),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(
                          double.infinity,
                          50,
                        ),
                        backgroundColor: white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onPressed: downloadPhoto,
                      child: const Text(
                        'Download Image',
                        style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
