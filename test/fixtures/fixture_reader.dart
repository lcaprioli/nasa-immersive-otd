import 'dart:io';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();
List<int> image(String name) => File('test/fixtures/$name').readAsBytesSync();
