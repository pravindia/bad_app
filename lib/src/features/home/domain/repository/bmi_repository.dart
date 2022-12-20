import '../../../../core/base/type_defs.dart';
import '../entities/bmi_record.dart';

/// {@template bmi_repository}
/// A repository responsible for crud ops of bmi records.
/// {@endtemplate}
abstract class IBmiRepository {
  /// get last recorded bmi record of the auth user
  FailureOr<BMIRecordEntity?> lastBmiRecord();

  /// get all bmi records of the auth user
  FailureOr<List<BMIRecordEntity>> getAllBmiRecords();

  /// save a new bmi record
  FailureOr<bool> saveBmiRecord(BMIRecordEntity entry);

  /// delete a bmi record
  FailureOr<bool> deleteBmiRecord(String id);
}
