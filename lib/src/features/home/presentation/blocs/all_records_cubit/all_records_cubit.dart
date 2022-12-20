// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base/usecase.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/bmi_record.dart';
import '../../../domain/usecases/delete_record_usecase.dart';
import '../../../domain/usecases/get_all_records_usecase.dart';

part 'all_records_cubit.freezed.dart';
part 'all_records_state.dart';

@injectable
class AllRecordsCubit extends Cubit<AllRecordsState> {
  AllRecordsCubit(
    this._allRecords,
    this._deleteRecord,
  ) : super(const AllRecordsState.initial());

  final GetAllRecords _allRecords;
  final DeleteRecord _deleteRecord;

  Future<void> fetch() async {
    final result = await _allRecords(const NoParams());
    emit(result.fold(_Failed.new, _Loaded.new));
  }

  Future<void> delete(String id) async {
    final result = await _deleteRecord(id);
    result.fold((l) => null, (r) => fetch());
  }
}
