// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../core/device/network/network_info.dart' as _i3;
import '../../external/local_db.dart' as _i4;
import '../../features/home/data/repository/bmi_repository.dart' as _i10;
import '../../features/home/data/sources/bmi_source.dart' as _i6;
import '../../features/home/domain/repository/bmi_repository.dart' as _i9;
import '../../features/home/domain/usecases/add_record_usecase.dart' as _i14;
import '../../features/home/domain/usecases/delete_record_usecase.dart' as _i16;
import '../../features/home/domain/usecases/get_all_records_usecase.dart'
    as _i17;
import '../../features/home/domain/usecases/get_latest_record_usecase.dart'
    as _i18;
import '../../features/home/presentation/blocs/all_records_cubit/all_records_cubit.dart'
    as _i19;
import '../../features/home/presentation/blocs/bmi_cubit/bmi_cubit.dart'
    as _i21;
import '../../features/shared/auth/data/repositories/auth_repository_impl.dart'
    as _i8;
import '../../features/shared/auth/data/sources/auth_source.dart' as _i5;
import '../../features/shared/auth/domain/repositories/auth_repository.dart'
    as _i7;
import '../../features/shared/auth/domain/usecases/create_new_user_usecase.dart'
    as _i15;
import '../../features/shared/auth/domain/usecases/is_user_loggedin_usecase.dart'
    as _i11;
import '../../features/shared/auth/domain/usecases/logout_user_usecase.dart'
    as _i12;
import '../../features/shared/auth/domain/usecases/signin_user_usecase.dart'
    as _i13;
import '../../features/shared/auth/presentation/blocs/auth_bloc/auth_bloc.dart'
    as _i20; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initSL(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.INetworkInfo>(() => _i3.SimpleNetworkInformationImpl());
  gh.singleton<_i4.LocalDatabase>(
    _i4.LocalDatabase.getInstance(),
    dispose: (i) => i.dispose(),
  );
  gh.lazySingleton<_i5.IAuthSource>(
      () => _i5.LocalAuthSource(get<_i4.LocalDatabase>()));
  gh.lazySingleton<_i6.IBmiSource>(() => _i6.BmiSource(
        get<_i5.IAuthSource>(),
        get<_i4.LocalDatabase>(),
      ));
  gh.lazySingleton<_i7.IAuthRepository>(() => _i8.AuthRepository(
        get<_i3.INetworkInfo>(),
        get<_i5.IAuthSource>(),
      ));
  gh.lazySingleton<_i9.IBmiRepository>(
      () => _i10.BmiRepository(get<_i6.IBmiSource>()));
  gh.lazySingleton<_i11.IsUserLoggedIn>(
      () => _i11.IsUserLoggedIn(get<_i7.IAuthRepository>()));
  gh.lazySingleton<_i12.LogOutUser>(
      () => _i12.LogOutUser(get<_i7.IAuthRepository>()));
  gh.lazySingleton<_i13.SignInUser>(
      () => _i13.SignInUser(get<_i7.IAuthRepository>()));
  gh.lazySingleton<_i14.AddRecord>(
      () => _i14.AddRecord(get<_i9.IBmiRepository>()));
  gh.lazySingleton<_i15.CreateNewUser>(
      () => _i15.CreateNewUser(get<_i7.IAuthRepository>()));
  gh.lazySingleton<_i16.DeleteRecord>(
      () => _i16.DeleteRecord(get<_i9.IBmiRepository>()));
  gh.lazySingleton<_i17.GetAllRecords>(
      () => _i17.GetAllRecords(get<_i9.IBmiRepository>()));
  gh.lazySingleton<_i18.GetLatestRecord>(
      () => _i18.GetLatestRecord(get<_i9.IBmiRepository>()));
  gh.factory<_i19.AllRecordsCubit>(() => _i19.AllRecordsCubit(
        get<_i17.GetAllRecords>(),
        get<_i16.DeleteRecord>(),
      ));
  gh.factory<_i20.AuthBloc>(() => _i20.AuthBloc(
        get<_i11.IsUserLoggedIn>(),
        get<_i13.SignInUser>(),
        get<_i15.CreateNewUser>(),
        get<_i12.LogOutUser>(),
      ));
  gh.factory<_i21.BmiCubit>(() => _i21.BmiCubit(
        get<_i18.GetLatestRecord>(),
        get<_i14.AddRecord>(),
      ));
  return get;
}
