// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../core/network_services/api_execution.dart' as _i9;
import '../core/network_services/network_info.dart' as _i8;
import '../data/datasources/remote_datasources/user_remote_datasource.dart'
    as _i11;
import '../data/datasources/remote_datasources/user_remote_datasource_impl.dart'
    as _i12;
import '../data/mappers/my_user_mapper.dart' as _i3;
import '../data/mappers/user_mapper.dart' as _i4;
import '../data/repositories/authentication_repository_impl.dart' as _i6;
import '../data/repositories/user_repository_impl.dart' as _i14;
import '../domain/repositories/authenticaiton_repository.dart' as _i5;
import '../domain/repositories/user_repository.dart' as _i13;
import '../domain/usecases/authentication_usecase.dart' as _i7;
import '../domain/usecases/user_usecase.dart' as _i15;
import '../presentation/blocs/sign_in/sign_in_bloc.dart' as _i10;
import '../presentation/blocs/user_bloc.dart' as _i16;

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
    gh.singleton<_i3.MyUserMapper>(() => _i3.MyUserMapper());
    gh.singleton<_i4.UserMapper>(() => _i4.UserMapper());
    gh.factory<_i5.AuthenticationRepository>(() => _i6.AuthenticationImpl());
    gh.singleton<_i7.AuthenticationUseCase>(
        () => _i7.AuthenticationUseCase(gh<_i5.AuthenticationRepository>()));
    gh.singleton<_i8.NetworkInfo>(() => _i8.NetworkInfoImpl());
    gh.singleton<_i9.ApiExecution>(
        () => _i9.ApiExecution(gh<_i8.NetworkInfo>()));
    gh.singleton<_i10.SignInBloc>(
        () => _i10.SignInBloc(useCase: gh<_i7.AuthenticationUseCase>()));
    gh.factory<_i11.UserRemoteDataSource>(
        () => _i12.UserRemoteDatasourceImpl(gh<_i9.ApiExecution>()));
    gh.factory<_i13.UserRepository>(() => _i14.UserRepositoryImpl(
          gh<_i11.UserRemoteDataSource>(),
          gh<_i4.UserMapper>(),
        ));
    gh.singleton<_i15.UserUseCase>(
        () => _i15.UserUseCase(gh<_i13.UserRepository>()));
    gh.singleton<_i16.UserBloc>(
        () => _i16.UserBloc(useCase: gh<_i15.UserUseCase>()));
    return this;
  }
}
