// ignore_for_file: public_member_api_docs

import 'dart:convert';
import 'dart:math' show pow;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../core/constants/constraints/constraints.dart';

/// {@template bmi_record}
/// an entity that stores the info about height, weight and timestamp.
/// {@endtemplate}
class BMIRecordEntity extends Equatable {
  /// {@macro bmi_record}
  factory BMIRecordEntity.fromJson(String source) =>
      BMIRecordEntity.fromMap(json.decode(source));

  /// {@macro bmi_record}
  factory BMIRecordEntity.fromMap(Map<String, dynamic> map) {
    return BMIRecordEntity(
      userId: map['userId'],
      id: map['id'] ?? '',
      height: map['height']?.toDouble() ?? 0.0,
      weight: map['weight']?.toDouble() ?? 0.0,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }

  /// {@macro bmi_record}
  const BMIRecordEntity({
    this.userId,
    this.id,
    required this.height,
    required this.weight,
    required this.timestamp,
  });

  final String? userId;

  /// a unique id
  final String? id;

  /// height in cm
  final double height;

  /// weight in kg
  final double weight;

  /// timestamp for this record
  final DateTime timestamp;

  /// get bmi value for this record
  double get bmi {
    return weight / pow(height, 2);
  }

  /// color code for the bmi
  Color get bmiColor {
    final _bmi = bmi;

    if (_bmi < AppConstraints.underWeightBMI) {
      return AppConstraints.underWeightColor;
    }
    if (_bmi > AppConstraints.normalWeightBMI.head &&
        _bmi <= AppConstraints.normalWeightBMI.tail) {
      return AppConstraints.normalWeightColor;
    }
    if (_bmi > AppConstraints.overWeightBMI.head &&
        _bmi <= AppConstraints.overWeightBMI.tail) {
      return AppConstraints.overWeightColor;
    }
    if (_bmi > AppConstraints.obeseWeightBMI.head &&
        _bmi <= AppConstraints.obeseWeightBMI.tail) {
      return AppConstraints.obeseWeightColor;
    }
    if (_bmi > AppConstraints.extremelyObeseWeightBMI) {
      return AppConstraints.extremelyObeseWeightColor;
    }
    return Colors.white;
  }

  /// {@macro bmi_record}
  BMIRecordEntity copyWith({
    String? userId,
    String? id,
    double? height,
    double? weight,
    DateTime? timestamp,
  }) {
    return BMIRecordEntity(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  /// {@macro bmi_record}
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'id': id,
      'height': height,
      'weight': weight,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  /// {@macro bmi_record}
  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'BMIRecordEntity(userId: $userId, id: $id, height: '
        '$height, weight: $weight, timestamp: $timestamp)';
  }

  @override
  List<Object?> get props {
    return [
      userId,
      id,
      height,
      weight,
      timestamp,
    ];
  }
}

class BmiRecordAdapter extends TypeAdapter<BMIRecordEntity> {
  @override
  final typeId = 2578;

  @override
  BMIRecordEntity read(BinaryReader reader) {
    return BMIRecordEntity.fromJson(reader.read());
  }

  @override
  void write(BinaryWriter writer, BMIRecordEntity obj) {
    writer.write(obj.toJson());
  }
}
