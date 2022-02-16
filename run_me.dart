import 'dart:io';

void main(List<String> args) async {
  await runIntegrationTest();
}

Future<Process> runUnitTests() {
  return Process.start(
    'flutter',
    ['test'],
    runInShell: true,
    mode: ProcessStartMode.inheritStdio,
  );
}

Future<Process> runIntegrationTest() async {
  final process = Process.start(
    'flutter',
    [
      'drive',
      '--driver=test/integration_test_driver.dart',
      '--target=test/integration_test.dart',
    ],
    runInShell: true,
    mode: ProcessStartMode.inheritStdio,
  );
  return process;
}
