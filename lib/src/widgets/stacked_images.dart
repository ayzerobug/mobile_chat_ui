import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StackedImages extends StatelessWidget {
  final List<String> imageUris;
  final double imageSize;
  final double overlap;

  const StackedImages({
    super.key,
    required this.imageUris,
    this.imageSize = 200, // Default size of each image
    this.overlap = 30, // How much each image overlaps the one before it
  });

  @override
  Widget build(BuildContext context) {
    if (imageUris.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: imageSize + overlap, // Adjust height based on images
      width: imageSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(imageUris.length, (index) {
          final uri = imageUris[index];
          final double rotation = Random().nextDouble() * 10 -
              5; // Random rotation between -5° and 5°
          final double offsetY = index * overlap; // Overlapping effect

          return Positioned(
            top: offsetY,
            left: 0,
            right: 0,
            child: Transform.rotate(
              angle: rotation * (pi / 180), // Convert degrees to radians
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: uri.startsWith("http")
                    ? CachedNetworkImage(
                        imageUrl: uri,
                        fit: BoxFit.cover,
                        width: imageSize,
                        height: imageSize,
                      )
                    : Image.file(
                        File(uri),
                        fit: BoxFit.cover,
                        width: imageSize,
                        height: imageSize,
                      ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
