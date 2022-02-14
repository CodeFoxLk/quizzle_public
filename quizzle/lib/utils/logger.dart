import 'package:logger/logger.dart';

class AppLogger {
  static final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 200, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
  );

  static void i(dynamic message){
    logger.i(message);
  }
  static void d(dynamic message){
    logger.d(message);
  }
  static void w(dynamic message){
    logger.w(message);
  }
  static void e(dynamic message){
    logger.e(message);
  }
  static void wtf(dynamic message){
    logger.wtf(message);
  }
  
}
