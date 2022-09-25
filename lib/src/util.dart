import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;

import 'package:ssh_manager/exceptions.dart' as exc;

class Host {
  final String algorithm;
  final String host;
  final String publicKey;

  Host(this.algorithm, this.host, this.publicKey);
}

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

getSshKnowHosts(String sshDirectory) {
  // base64Decode(source)
  List<List<String>> knownHosts = new File('$sshDirectory/known_hosts')
      .readAsLinesSync()
      .map((String host) => host.split('|')
      .where((String element) => element.isNotEmpty)
      .toList()
  ).toList();
  List<Host> mappedHosts = [];
  for (var hostStringElements in knownHosts) {
    var host = new Host(
      hostStringElements[0],
      hostStringElements[1],
      hostStringElements[2],
    );
    print(host.host);
    mappedHosts.add(host);
  }
  // TODO: Research known_hosts formatting and how to decode server ip-address
  return mappedHosts;
}
