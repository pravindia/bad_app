import 'package:injectable/injectable.dart';

import '../../../../core/base/type_defs.dart';
import '../../../../core/base/usecase.dart';
import '../entities/bmi_record.dart';
import '../repository/bmi_repository.dart';

/// {@template add_record_usecase}
/// Add a new record
/// {@endtemplate}
@lazySingleton
class AddRecord implements IUseCase<bool, BMIRecordEntity> {
  /// {@macro add_record_usecase}
  const AddRecord(this._repository);

  final IBmiRepository _repository;

  @override
  FailureOr<bool> call(BMIRecordEntity params) async {
    return _repository.saveBmiRecord(params);
  }
}
