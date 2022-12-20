// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/base/usecase.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/bmi_record.dart';
import '../../../domain/usecases/add_record_usecase.dart';
import '../../../domain/usecases/get_latest_record_usecase.dart';

part 'bmi_cubit.freezed.dart';
part 'bmi_state.dart';

@injectable
class BmiCubit extends Cubit<BmiState> {
  BmiCubit(
    this._latestRecord,
    this._addRecord,
  ) : super(const BmiState.initial());

  final GetLatestRecord _latestRecord;
  final AddRecord _addRecord;

  Future<void> fetch() async {
    final result = await _latestRecord(const NoParams());
    emit(result.fold(_Failed.new, _Loaded.new));
  }

  Future<void> saveRecord(BMIRecordEntity record) async {
    final result = await _addRecord(record);
    emit(
      result.fold(
        _Failed.new,
        (r) => _Loaded(record),
      ),
    );
  }
}
