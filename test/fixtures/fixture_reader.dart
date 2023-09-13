
import 'dart:io';

String readFixture(String jsonName) => File('test/fixtures/json/$jsonName').readAsStringSync();