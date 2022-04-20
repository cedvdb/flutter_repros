# Run unit tests

`flutter test test/widget_test.dart`

# Run integration tests android

1. Run an android emulator.

`flutter drive --driver=test/integration_test_driver.dart --target=test/integration_test.dart`

# Run integration tests chrome

1. Install chromedrive (download zip, add path to environment variable) 
2. run chrome driver `chromedriver --port=4444`

`flutter drive --driver=test/integration_test_driver.dart --target=test/integration_test.dart -d web-server`
