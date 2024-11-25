import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class image extends StatefulWidget {
  const image({super.key,required this.imageUURL});
  final String imageUURL;

  @override
  State<image> createState() => _imageState();
}

class _imageState extends State<image> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imageUURL,
      placeholder: (context, url) => CircularProgressIndicator.adaptive(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
