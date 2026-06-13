import 'package:flutter/material.dart';
import '/features/annoucements/widgets/full_screen_image_viewer.dart';

class AttachmentImage extends StatefulWidget {
  final String imageUrl;

  const AttachmentImage({required this.imageUrl});

  @override
  State<AttachmentImage> createState() => _AttachmentImageState();
}

class _AttachmentImageState extends State<AttachmentImage> {
  bool failed = false;

  @override
  Widget build(BuildContext context) {
    if (failed) {
      return Container(
        height: 180,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.broken_image),
            TextButton(
              onPressed: () {
                setState(() {
                  failed = false;
                });
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FullScreenImageViewer(imageUrl: widget.imageUrl),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          widget.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            failed = true;
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => setState(() {}),
            );
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
