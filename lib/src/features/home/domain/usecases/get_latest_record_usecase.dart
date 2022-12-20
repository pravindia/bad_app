import 'package:injectable/injectable.dart';

import '../../../../core/base/type_defs.dart';
import '../../../../core/base/usecase.dart';
import '../entities/bmi_record.dart';
import '../repository/bmi_repository.dart';

/// {@template get_latest_record_usecase}
/// Get last BMI record
/// {@endtemplate}
@lazySingleton
class GetLatestRecord implements IUseCase<BMIRecordEntity?, NoParams> {
  /// {@macro get_latest_record_usecase}
  const GetLatestRecord(
    this._repository,
  );

  final IBmiRepository _repository;

  @override
  FailureOr<BMIRecordEntity?> call(NoParams params) async {
    return _repository.lastBmiRecord();
  }
}
