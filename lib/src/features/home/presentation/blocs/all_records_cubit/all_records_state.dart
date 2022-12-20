// ignore_for_file: public_member_api_docs

part of 'all_records_cubit.dart';

@freezed
class AllRecordsState with _$AllRecordsState {
  const factory AllRecordsState.initial() = _Initial;
  const factory AllRecordsState.loaded(List<BMIRecordEntity> records) = _Loaded;
  const factory AllRecordsState.failed(Failure failure) = _Failed;
}
