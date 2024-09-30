import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class HttpError extends Error {
  final int statusCode;
  final String message;

  HttpError(this.statusCode, this.message);

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }

  getMensaje() {
    return this.message;
  }
}
