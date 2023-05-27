import 'package:flutter/material.dart';
import 'package:purala/constants/path_constants.dart';

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

  bool isNullOrEmpty(String? str) {
    return str == null || str.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    String uri = isNullOrEmpty(url) ? "${PathConstants.iconsPath}/purala-square-logo.png" : url!;
  
    final isValidUrl = Uri.parse(uri).isAbsolute;

    if (isValidUrl) {
      return Image.network(
        uri,
        fit: BoxFit.contain,
        height: height ?? 120,
        width: width ?? 120,
      );
    } else {
      return Image.asset(
        uri,
        fit: BoxFit.contain,
        height: height ?? 120,
        width: width ?? 120,
      );
    }
  }
}
