import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:project_zomboid_server/app/shared/config.dart';
import 'dart:convert';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  Process? process;
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
                child: const Text('teste'),
                onPressed: () async {
                  // ByteData bytes = await rootBundle.load("assets/steamcmd.exe");

                  Process process = await Process.start("$applicationPath\\files\\steamcmd.exe", [], runInShell: true);

                  process.stdout.transform(utf8.decoder).forEach((x) => print(x)).then((value) => process.stdin.writeln('help'));

                  // await File("$applicationPath\\files\\steamcmd.exe").writeAsBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
                }),
            FilledButton(
                child: const Text('teste1'),
                onPressed: () async {
                  // ByteData bytes = await rootBundle.load("assets/steamcmd.exe");

                  // await File("$applicationPath\\files\\steamcmd.exe").writeAsBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
                }),
          ],
        ),
      ),
    );
  }
}
