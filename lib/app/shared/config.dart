import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:process_run/shell.dart';

String zomboidFiles = Platform.isWindows ? "%UserProfile%\\zomboid" : "~/Zomboid";

String serverName = "zomboid-server";
int ramDedicated = 6;
const bool serverHasInstalled = false;
String? dataBasePassword;

/// Visível com inputs para o usuário
Map serverSettings = {};

const String applicationName = "zomboid-server";

/// %temp%
String instalationpath = Directory.systemTemp.path;

/// instalationpath\applicationName
String applicationPath = "$instalationpath\\$applicationName";

Future createInstalationPath() async {
  Shell shell = Shell(verbose: false);

  shell = shell.cd(instalationpath);
  var dir = (await shell.run("dir")).first;

  if (dir.outText.contains(applicationName)) {
    shell = shell.cd(applicationName);
  } else {
    await shell.run('mkdir $applicationName');
    shell = shell.cd(applicationName);

    var projectDir = (await shell.run("dir")).first;
    if (!projectDir.outText.contains("backup")) {
      await shell.run('mkdir backup');
    }
    if (!projectDir.outText.contains("files")) {
      await shell.run('mkdir files');
    }
    shell = shell.cd('files');
    var filesDir = (await shell.run("dir")).first;

    if (!filesDir.outText.contains("server-data")) {
      await shell.run('mkdir server-data');
    }
  }
  if (!dir.outText.contains("steamcmd")) {
    ZipDecoder decoder = ZipDecoder();
    ByteData bytes = await rootBundle.load('assets/steamcmd.zip');
    Archive archive = decoder.decodeBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    if (archive.files.first.isFile) {
      await File("$applicationPath\\files\\steamcmd.exe").writeAsBytes(archive.files.first.content);
    }
  }

  shell.kill();
}

setServerConfigs(BuildContext context) async {
  File configs = File("$applicationPath\\files\\server-data\\StartServer64.bat");
  String value = await configs.readAsString();

  value = value.replaceAll("-Xms16g", "-Xms${ramDedicated}g").replaceAll("Xmx16g", "Xmx${ramDedicated}g");
  value = value.replaceAll("-statistic", '-servername "$serverName" -statistic');

  await configs.writeAsString(value);
}

importServerConfig() async {
  File defaultConfigFile = File("$zomboidFiles/Server/$serverName.ini");

  print(defaultConfigFile.readAsStringSync());
}
