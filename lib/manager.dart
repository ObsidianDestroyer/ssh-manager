import 'dart:io';

import 'package:path/path.dart';
import 'package:ssh_manager/exceptions.dart';
import 'package:ssh_manager/src/util.dart';


void initManager() {
  try {
    String homeDirectory = getHomeDirectory();
    String sshDirectory = getSshDirectory(homeDirectory);
    List<Host> knownHosts = getSshKnowHosts(sshDirectory);
    // for (var host in knownHosts) {
    //   print(host.algorithm);
    // }
  } on NullThrownError {
    stdout.writeln(
      'Your "\$HOME" environment variable '
          'is empty or NULL. Maybe your OS is unsupported.',
    );
    exit(1);
  } on UnsupportedOperatingSystem catch(err) {
    stdout.writeln(err);
    exit(1);
  } on NoSuchDirectory catch(err) {
    stdout.writeln(err);
    exit(1);
  }
  catch (err) {
    stdout.writeln('Occurred unhandled exception: $err');
    exit(1);
  }
}
