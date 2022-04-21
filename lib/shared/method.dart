part of 'shared.dart';

String baseUrl = "http://192.168.43.119:3000";
String shareUID = "";
int timestamp = DateTime.now().millisecondsSinceEpoch;

Future pickImage() async {
  File imageRes;
  dynamic inputImage;
  final textDetector = GoogleMlKit.vision.textDetector();
  dynamic image;
  String dataText = "";

  try {
    image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 25,
        preferredCameraDevice: CameraDevice.rear);
    if (image == null) return;

    inputImage = InputImage.fromFilePath(image.path);

    final RecognisedText recognisedText =
        await textDetector.processImage(inputImage);

    String text = recognisedText.text;
    for (TextBlock block in recognisedText.blocks) {
      final Rect rect = block.rect;
      final List<Offset> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<String> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          // Same getters as TextBlock
          dataText += element.text + " ";
        }
        dataText += '\n';
      }
    }

    return [dataText, File(image.path)];
  } catch (err) {
    print(err);
    return false;
  }
}

String recentTime(String timeString) {
  int time = int.parse(timeString);
  if (time >= timestamp - 60 * 60 * 24 * 1000) {
    return "A few hours ago";
  } else if (time >= timestamp - 60 * 60 * 24 * 1000 * 7) {
    return "A few days ago";
  } else if (time >= timestamp - 60 * 60 * 24 * 1000 * 30) {
    return "A few weeks ago";
  } else {
    return "A long time ago";
  }

  return "";
}
