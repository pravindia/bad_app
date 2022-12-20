// ignore_for_file: public_member_api_docs

part of 'bmi_cubit.dart';

@freezed
class BmiState with _$BmiState {
  const factory BmiState.initial() = _Initial;

  const factory BmiState.loaded(BMIRecordEntity? record) = _Loaded;

  const factory BmiState.failed(Failure failure) = _Failed;
}
