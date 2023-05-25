import 'package:flutter/material.dart';
import 'package:purala/constants/path_constants.dart';

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
    if (url.isEmpty) {
      return Image.asset(
        url.isEmpty ? "${PathConstants.iconsPath}/purala-square-logo.png" : url,
        fit: BoxFit.contain,
        height: height ?? 120,
        width: width ?? 120,
      );
    } else {
      return Image.network(
        url,
        fit: BoxFit.contain,
        height: height ?? 120,
        width: width ?? 120,
      );
    }
  }
}
