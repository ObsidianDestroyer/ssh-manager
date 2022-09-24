import 'dart:io';

import 'package:path/path.dart' as path;

import 'package:ssh_manager/exceptions.dart' as exc;

String getHomeDirectory() {
  switch (Platform.operatingSystem) {
    case 'linux':
    case 'macos':
      return Platform.environment['HOME']!;
    default:
      throw new exc.UnsupportedOperatingSystem();
  }
}


String getSshDirectory(String homeDirectory) {
  Directory sshDirectory = Directory('$homeDirectory/.ssh');
  if (!sshDirectory.existsSync())
    throw new exc.NoSuchDirectory(sshDirectory.path);
  return '$homeDirectory/.ssh';
}
