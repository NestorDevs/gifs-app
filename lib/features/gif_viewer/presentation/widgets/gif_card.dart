import 'package:flutter/material.dart';
import 'package:giphy_gifs_core/giphy_gifs_core.dart';

class GifCard extends StatelessWidget {
  final GIF gif;

  const GifCard({required this.gif, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(gif.originalImage.url),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(gif.title),
          ),
        ],
      ),
    );
  }
}