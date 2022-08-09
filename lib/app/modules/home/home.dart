import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show Scaffold;
import 'dart:io';
import 'dart:convert';

import 'package:project_zomboid_server/app/shared/config.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton(
              child: const Text('teste'),
              onPressed: () async {
                Process? process = await Process.start(
                  "$applicationPath\\files\\steamcmd.exe +force_install_dir $applicationPath\\files\\server-data +login anonymous +app_update 380870 validate +quit",
                  [],
                  runInShell: true,
                );

                process.stdout.transform(utf8.decoder).forEach((x) {
                  if (x.contains("Success! App '380870' fully installed.")) {
                    showDialog(
                      context: context,
                      builder: (_) => ContentDialog(
                        content: const Text("Servidor Instalado com Sucesso"),
                        actions: [Button(child: const Text('Ok'), onPressed: () => Navigator.pop(context))],
                      ),
                      barrierDismissible: true,
                    );
                  }
                });
              }),
        ],
      ),
    );
  }
}

