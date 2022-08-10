import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show Scaffold;
import 'dart:io';
import 'dart:convert';

import 'package:project_zomboid_server/app/shared/config.dart';
import 'package:project_zomboid_server/app/shared/models/alerts.dart';
import 'package:uuid/uuid.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton(
              child: const Text('Instalar Servidor'),
              onPressed: () async {
                Map hardware = await Alert.getInputServerConfigs(context);

                ramDedicated = hardware['ram'];
                serverName = hardware['serverName'];

                Process process = await Process.start(
                  "$applicationPath\\files\\steamcmd.exe +force_install_dir $applicationPath\\files\\server-data +login anonymous +app_update 380870 validate +quit",
                  [],
                  runInShell: true,
                );

                process.stderr.transform(utf8.decoder).forEach((x) {
                  Alert.showErrorAlert(context, x);
                  process.kill();
                });

                process.stdout.transform(utf8.decoder).forEach((x) async {
                  if (x.contains("Success! App '380870' fully installed.")) {
                    await setServerConfigs(context);
                    Alert.showServerCreatedAlert(context);
                    process.kill();
                  }
                });
              }),
          FilledButton(
              child: const Text('Iniciar Servidor'),
              onPressed: () async {
                Process process = await Process.start("$applicationPath\\files\\server-data\\StartServer64.bat", [], runInShell: true);

                process.stdout.transform(utf8.decoder).forEach((x) async {
                  if (x.contains("User 'admin' not found, creating it") || x.contains("Confirm the password:")) {
                    dataBasePassword ??= const Uuid().v1();
                    process.stdin.writeln(dataBasePassword);
                  }

                  if (x.contains("server is listening on port")) {
                    Alert.showServerStarted(context);
                  }
                });
              }),
          FilledButton(
              child: const Text('teste'),
              onPressed: () async {
                print(await Alert.getInputServerConfigs(context));
              }),
        ],
      ),
    );
  }
}
