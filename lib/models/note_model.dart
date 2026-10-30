import 'package:flutter/material.dart';

class NoteModel {
  final String id;
  String title;
  String content;
  String date;
  String time;
  String category;
  String icon;
  String priority;
  Color cardColor;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.time,
    required this.category,
    required this.icon,
    required this.priority,
    required this.cardColor,
  });

  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    String? date,
    String? time,
    String? category,
    String? icon,
    String? priority,
    Color? cardColor,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      time: time ?? this.time,
      category: category ?? this.category,
      icon: icon ?? this.icon,
      priority: priority ?? this.priority,
      cardColor: cardColor ?? this.cardColor,
    );
  }
}

