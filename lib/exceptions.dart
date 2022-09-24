import 'package:path/path.dart' as path;


class UnsupportedOperatingSystem implements Exception {
  @override
  String toString() {
    return 'Can\'t find \$HOME environment variable on your OS. '
        'So it seems to be unsupported.';
  }
}

class NoSuchDirectory implements Exception {
  String directoryPath;

  NoSuchDirectory(this.directoryPath);

  @override
  String toString() => 'Directory "$directoryPath" is not found.';
}
