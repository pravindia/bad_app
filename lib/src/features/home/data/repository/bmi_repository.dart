import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/type_defs.dart';
import '../../../../core/error/exception_to_failure_mapper.dart';
import '../../domain/entities/bmi_record.dart';
import '../../domain/repository/bmi_repository.dart';
import '../sources/bmi_source.dart';

/// {@macro bmi_repository}
@LazySingleton(as: IBmiRepository)
class BmiRepository implements IBmiRepository {
  /// {@macro bmi_repository}
  const BmiRepository(this._source);
  final IBmiSource _source;

  @override
  FailureOr<bool> deleteBmiRecord(String id) async {
    try {
      final result = await _source.deleteBmiRecord(id);
      return Right(result);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  FailureOr<List<BMIRecordEntity>> getAllBmiRecords() async {
    try {
      final result = await _source.getAllBmiRecords();
      return Right(result);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  FailureOr<BMIRecordEntity?> lastBmiRecord() async {
    try {
      final result = await _source.lastBmiRecord();
      return Right(result);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  FailureOr<bool> saveBmiRecord(BMIRecordEntity entry) async {
    try {
      final result = await _source.saveBmiRecord(entry);
      return Right(result);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
