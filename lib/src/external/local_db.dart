import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../features/home/domain/entities/bmi_record.dart';

/// A class that handles the storage of the [Hive] database.
@singleton
class LocalDatabase {
  LocalDatabase._();

  late Box _authBox;
  late Box<BMIRecordEntity> _bmiBox;

  /// initialize LocalDatabase
  Future<void> init() async {
    Hive.registerAdapter(BmiRecordAdapter());
    await Hive.initFlutter();
    _authBox = await Hive.openBox('auth');
    _bmiBox = await Hive.openBox('bmi');
  }

  static final LocalDatabase _instance = LocalDatabase._();

  /// Returns the instance of the [LocalDatabase].
  @factoryMethod
  static LocalDatabase getInstance() {
    return _instance;
  }

  /// get authBox
  Box get authBox => _authBox;

  /// get bmiBox
  Box<BMIRecordEntity> get bmiBox => _bmiBox;

  /// close the database
  @disposeMethod
  Future<void> dispose() async {
    await Hive.close();
  }
}
