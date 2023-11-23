/* import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:super_clipboard/super_clipboard.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  void copyText() async {
    final item = DataWriterItem();
    item.add(Formats.htmlText('<b>This is a <em>HTML</en> value</b>.'));
    item.add(Formats.plainText('This is a plaintext value.'));
    await ClipboardWriter.instance.write([item]);
  }

  void copyTextLazy() async {
    final item = DataWriterItem();
    item.add(Formats.htmlText.lazy(() {
      showMessage('Lazy rich text requested.');
      return '<b>This is a <em>HTML</en> value</b> generated <u>on demand</u>.';
    }));
    item.add(Formats.plainText.lazy(() {
      showMessage('Lazy plain text requested.');
      return 'This is a plaintext value generated on demand.';
    }));
    await ClipboardWriter.instance.write([item]);
  }

  void copyImage() async {
    final image = await createImageData(Colors.red);
    final item = DataWriterItem(suggestedName: 'RedCircle.png');
    item.add(Formats.png(image));
    await ClipboardWriter.instance.write([item]);
  }

  void copyImageLazy() async {
    final item = DataWriterItem(suggestedName: 'BlueCircle.png');
    item.add(Formats.png.lazy(() {
      showMessage('Lazy image requested.');
      return createImageData(Colors.blue);
    }));
    await ClipboardWriter.instance.write([item]);
  }

  void copyCustomData() async {
    final item = DataWriterItem();
    item.add(formatCustom(Uint8List.fromList([1, 2, 3, 4])));
    await ClipboardWriter.instance.write([item]);
  }

  void copyCustomDataLazy() async {
    final item = DataWriterItem();
    item.add(formatCustom.lazy(() async {
      showMessage('Lazy custom data requested.');
      return Uint8List.fromList([1, 2, 3, 4, 5, 6]);
    }));
    await ClipboardWriter.instance.write([item]);
  }

  void copyUri() async {
    final item = DataWriterItem();
    item.add(Formats.uri(NamedUri(
        Uri.parse('https://github.com/superlistapp/super_native_extensions'),
        name: 'Super Native Extensions')));
    await ClipboardWriter.instance.write([item]);
  }

  void _paste() async {
    final reader = await ClipboardReader.readClipboard();
    final readers = await Future.wait(
      reader.items.map((e) => ReaderInfo.fromReader(e)),
    );
    if (!mounted) {
      return;
    }
    buildWidgetsForReaders(context, readers, (widgets) {
      setState(() {
        contentWidgets = widgets;
      });
    });
  }

  var contentWidgets = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: HomeLayout(
        mainContent: contentWidgets
            .intersperse(const SizedBox(height: 10))
            .toList(growable: false),
        buttons: [
          OutlinedButton(
            onPressed: copyText,
            child: const Text('Copy Text'),
          ),
          OutlinedButton(
              onPressed: copyTextLazy, child: const Text('Copy Text - Lazy')),
          OutlinedButton(onPressed: copyImage, child: const Text('Copy Image')),
          OutlinedButton(
              onPressed: copyImageLazy, child: const Text('Copy Image - Lazy')),
          OutlinedButton(
              onPressed: copyCustomData, child: const Text('Copy Custom')),
          OutlinedButton(
              onPressed: copyCustomDataLazy,
              child: const Text('Copy Custom - Lazy')),
          OutlinedButton(onPressed: copyUri, child: const Text('Copy URI')),
          OutlinedButton(
              onPressed: _paste,
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
              ),
              child: const Text('Paste')),
        ],
      ),
    );
  }
}

Future<Uint8List> createImageData(Color color) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final paint = Paint()..color = color;
  canvas.drawOval(const Rect.fromLTWH(0, 0, 200, 200), paint);
  final picture = recorder.endRecording();
  final image = await picture.toImage(200, 200);
  final data = await image.toByteData(format: ui.ImageByteFormat.png);
  return data!.buffer.asUint8List();
} */