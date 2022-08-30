import 'dart:convert';

import 'package:flutter/material.dart';

class Record {
  final String userId;
  final String date;
  Record(this.userId, this.date);
  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      json['date'],
      json['time'],
    );
  }
}
