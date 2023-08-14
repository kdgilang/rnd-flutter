import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:purala/presentation/core/consts/color_constants.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    this.url,
    this.height,
    this.width,
  });

  final String? url;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return 
    
    CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: url!,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
        LoadingAnimationWidget.fourRotatingDots(
          size: 50,
          color: ColorConstants.secondary,
        ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
