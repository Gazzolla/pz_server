import 'dart:io';

import 'package:process_run/shell.dart';

String zomboidFiles = Platform.isWindows ? "%UserProfile%\\zomboid" : "~/Zomboid";

String applicationName = "zomboid-server";
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
  }

  shell.kill();
}