import 'dart:async';

import 'package:byte_bistro/Services/http_service.dart';
import 'package:flutter/material.dart';

String shortId(String oId) {
  return oId.substring(0, 8);
}

typedef VarArgsCallback = dynamic Function(
    List<dynamic> args, Map<String, dynamic> kwargs);

class VarArgsFunction {
  final VarArgsCallback callback;
  static var _offset = 'Symbol("'.length;

  VarArgsFunction(this.callback);

  call() => callback([], {});

  @override
  dynamic noSuchMethod(Invocation inv) {
    return callback(
      inv.positionalArguments,
      inv.namedArguments.map(
        (_k, v) {
          var k = _k.toString();
          return MapEntry(k.substring(_offset, k.length - 2), v);
        },
      ),
    );
  }
}

class OurTimer {
  static List<Timer> timers = [];
  static void cancel() {
    while (timers.isNotEmpty) {
      // remove the first timer from the list and cancel it, unitl there is no more.
      timers.removeAt(0).cancel();
    }
  }
}

VarArgsFunction relativeNetworkImage = VarArgsFunction((args, kwargs) {
  return NetworkImage(PersistentHtpp.baseUrl + args[0],
      scale: kwargs['scale'], headers: kwargs['headers']);
}) as dynamic;

NetworkImage RelativeNetworkImage(String url) {
  return NetworkImage(PersistentHtpp.baseUrl + url, scale: 1.0);
}
