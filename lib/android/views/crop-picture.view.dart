import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class CropPictureView extends StatefulWidget {
  final String path;
  const CropPictureView({super.key, required this.path});

  @override
  State<CropPictureView> createState() => _CropPictureViewState();
}

class _CropPictureViewState extends State<CropPictureView> {
  final cropKey = GlobalKey<CropState>();

  Future<String> save() async {
    final crop = cropKey.currentState;
    final area = crop?.area;

    final uuid = Uuid();
    final path = join(
        (await getApplicationDocumentsDirectory()).path, '${uuid.v4()}.jpg');

    if (area != null) {
      final croppedFile = await ImageCrop.cropImage(
        file: File(
          widget.path,
        ),
        area: area,
      );
      final bytes = await croppedFile.readAsBytes();
      final buffer = bytes.buffer;

      File(path).writeAsBytes(
        buffer.asUint8List(
          bytes.offsetInBytes,
          bytes.lengthInBytes,
        ),
      );

      return path;
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recortar Image',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Crop(
        key: cropKey,
        image: FileImage(
          File(
            widget.path,
          ),
        ),
        aspectRatio: 1 / 1,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.save,
        ),
        onPressed: () {
          save().then((path) {
            Navigator.pop(context, path);
          });
        },
      ),
    );
  }
}
