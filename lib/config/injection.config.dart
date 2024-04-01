// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../core/network_services/api_execution.dart' as _i5;
import '../core/network_services/network_info.dart' as _i3;
import '../data/datasources/remote_datasources/user_remote_datasource.dart'
    as _i6;
import '../data/datasources/remote_datasources/user_remote_datasource_impl.dart'
    as _i7;
import '../data/mappers/user_mapper.dart' as _i4;
import '../data/repositories/user_repository_impl.dart' as _i9;
import '../domain/repositories/user_repository.dart' as _i8;
import '../domain/usecases/user_usecase.dart' as _i10;
import '../presentation/blocs/user_bloc.dart' as _i11;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.NetworkInfo>(_i3.NetworkInfoImpl());
    gh.singleton<_i4.UserMapper>(_i4.UserMapper());
    gh.singleton<_i5.ApiExecution>(_i5.ApiExecution(gh<_i3.NetworkInfo>()));
    gh.factory<_i6.UserRemoteDataSource>(
        () => _i7.UserRemoteDatasourceImpl(gh<_i5.ApiExecution>()));
    gh.factory<_i8.UserRepository>(() => _i9.UserRepositoryImpl(
          gh<_i6.UserRemoteDataSource>(),
          gh<_i4.UserMapper>(),
        ));
    gh.singleton<_i10.UserUseCase>(_i10.UserUseCase(gh<_i8.UserRepository>()));
    gh.singleton<_i11.UserBloc>(_i11.UserBloc(useCase: gh<_i10.UserUseCase>()));
    return this;
  }
}
