import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.url,
    this.height,
    this.width,
  });

  final String url;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final isValidUrl = Uri.parse(url).isAbsolute;
    if (isValidUrl) {
      return Image.network(
        url,
        fit: BoxFit.contain,
        height: height ?? 120,
        width: width ?? 120,
      );
    } else {
      return Image.asset(
        url,
        fit: BoxFit.contain,
        height: height ?? 120,
        width: width ?? 120,
      );
    }
  }
}
