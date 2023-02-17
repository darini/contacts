import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePictureView extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureView({super.key, required this.camera});

  @override
  State<TakePictureView> createState() => _TakePictureViewState();
}

class _TakePictureViewState extends State<TakePictureView> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<String> takePhoto() async {
    try {} catch (ex) {}
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nova Imagem',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SizedBox(
              width: double.infinity,
              child: CameraPreview(
                _controller,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          takePhoto().then(
            (path) {
              Navigator.pop(context, path);
            },
          );
        },
        child: const Icon(
          Icons.camera,
        ),
      ),
    );
  }
}
