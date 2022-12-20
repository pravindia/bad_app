import 'package:injectable/injectable.dart';

import '../../../../core/base/type_defs.dart';
import '../../../../core/base/usecase.dart';
import '../repository/bmi_repository.dart';

/// {@template delete_record_usecase}
/// Delete a record
/// {@endtemplate}
@lazySingleton
class DeleteRecord implements IUseCase<void, String> {
  /// {@macro delete_record_usecase}
  const DeleteRecord(
    this._repository,
  );

  final IBmiRepository _repository;

  @override
  FailureOr<void> call(String params) async {
    return _repository.deleteBmiRecord(params);
  }
}
