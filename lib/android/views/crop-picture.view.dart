import 'dart:io';

import 'package:flutter/material.dart';

class CropPictureView extends StatefulWidget {
  final String path;
  const CropPictureView({super.key, required this.path});

  @override
  State<CropPictureView> createState() => _CropPictureViewState();
}

class _CropPictureViewState extends State<CropPictureView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Image.file(
          fit: BoxFit.fill,
          File(
            widget.path,
          ),
        ),
      ),
    );
  }
}
