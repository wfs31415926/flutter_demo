import 'package:logger/logger.dart';

var logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        errorMethodCount: 8,
        lineLength: 90,
        colors: true,
        printEmojis: true,
        printTime: true));
