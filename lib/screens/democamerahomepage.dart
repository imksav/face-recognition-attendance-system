import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class DemoCameraHomePage extends StatefulWidget {
  const DemoCameraHomePage({Key? key}) : super(key: key);

  @override
  State<DemoCameraHomePage> createState() => _DemoCameraHomePageState();
}

class _DemoCameraHomePageState extends State<DemoCameraHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await availableCameras().then((value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CameraPage(
                            cameras: value,
                          ))));
            },
            child: const Text("Launch Camera")),
      ),
    );
  }
}

class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;

  const CameraPage({this.cameras, Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  XFile? pictureFile;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras![0],
      ResolutionPreset.max,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!!controller.value.isInitialized) {
      return const SizedBox(
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: SizedBox(
              height: 400.0,
              width: 400.0,
              child: CameraPreview(controller),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            child: const Text("Capture Image"),
            onPressed: () async {
              pictureFile = await controller.takePicture();
              setState(() {});
            },
          ),
        ),
        if (pictureFile != null)
          Image.network(
            pictureFile!.path,
            height: 200,
          )
      ],
    );
  }
}
