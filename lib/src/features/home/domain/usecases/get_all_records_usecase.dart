import '../../../../core/base/type_defs.dart';
import '../../../../core/base/usecase.dart';
import '../entities/bmi_record.dart';
import '../repository/bmi_repository.dart';

/// {@template get_all_records_usecase}
/// Get list of past recorded BMI values
/// {@endtemplate}
class GetAllRecords implements IUseCase<List<BMIRecordEntity>, NoParams> {
  /// {@macro get_all_records_usecase}
  const GetAllRecords(
    this._repository,
  );

  final IBmiRepository _repository;

  @override
  FailureOr<List<BMIRecordEntity>> call(NoParams params) async {
    return _repository.getAllBmiRecords();
  }
}
