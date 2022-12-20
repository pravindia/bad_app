import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../../external/local_db.dart';
import '../../../shared/auth/data/sources/auth_source.dart';
import '../../domain/entities/bmi_record.dart';

/// {@template bmi_source}
/// A source responsible for crud ops of bmi records.
/// {@endtemplate}
abstract class IBmiSource {
  /// get last recorded bmi record of the auth user
  Future<BMIRecordEntity?> lastBmiRecord();

  /// get all bmi records of the auth user
  Future<List<BMIRecordEntity>> getAllBmiRecords();

  /// save a new bmi record
  Future<bool> saveBmiRecord(BMIRecordEntity entry);

  /// delete a bmi record
  Future<bool> deleteBmiRecord(String id);
}

/// {@macro bmi_source}
@LazySingleton(as: IBmiSource)
class BmiSource implements IBmiSource {
  /// {@macro bmi_source}
  BmiSource(this._authSource, this._db);

  final IAuthSource _authSource;
  final LocalDatabase _db;

  Future<String?> get _userId async => (await _authSource.currentUser)?.id;

  @override
  Future<bool> deleteBmiRecord(String id) async {
    final userId = await _userId;
    if (userId == null) return false;

    await _db.bmiBox.delete(id);
    return true;
  }

  @override
  Future<List<BMIRecordEntity>> getAllBmiRecords() async {
    final userId = await _userId;
    if (userId == null) return const [];
    final records = List<BMIRecordEntity>.from(
      _db.bmiBox.values.where(
        (record) => record.userId == userId,
      ),
    );

    records.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return records;
  }

  @override
  Future<BMIRecordEntity?> lastBmiRecord() async {
    final userId = await _userId;
    if (userId == null) return null;

    final records = await getAllBmiRecords();
    if (records.isEmpty) return null;
    return records.last;
  }

  @override
  Future<bool> saveBmiRecord(BMIRecordEntity entry) async {
    final userId = await _userId;
    if (userId == null) return false;

    final id = const Uuid().v4();
    await _db.bmiBox.put(
      id,
      entry.copyWith(id: id, userId: id),
    );

    return true;
  }
}
