// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../core/network_services/api_execution.dart' as _i10;
import '../core/network_services/network_info.dart' as _i9;
import '../data/datasources/remote_datasources/user_remote_datasource.dart'
    as _i13;
import '../data/datasources/remote_datasources/user_remote_datasource_impl.dart'
    as _i14;
import '../data/mappers/my_user_mapper.dart' as _i3;
import '../data/mappers/user_mapper.dart' as _i4;
import '../data/repositories/authentication_repository_impl.dart' as _i7;
import '../data/repositories/user_repository_impl.dart' as _i16;
import '../domain/repositories/authenticaiton_repository.dart' as _i6;
import '../domain/repositories/user_repository.dart' as _i15;
import '../domain/usecases/authentication_usecase.dart' as _i8;
import '../domain/usecases/user_usecase.dart' as _i17;
import '../presentation/blocs/change_language/change_language_bloc.dart' as _i5;
import '../presentation/blocs/sign_in/sign_in_bloc.dart' as _i11;
import '../presentation/blocs/sign_up/sign_up_bloc.dart' as _i12;
import '../presentation/blocs/user_bloc.dart' as _i18;

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
    gh.singleton<_i5.ChangeLanguageBloc>(() => _i5.ChangeLanguageBloc());
    gh.factory<_i6.AuthenticationRepository>(() => _i7.AuthenticationImpl());
    gh.singleton<_i8.AuthenticationUseCase>(
        () => _i8.AuthenticationUseCase(gh<_i6.AuthenticationRepository>()));
    gh.singleton<_i9.NetworkInfo>(() => _i9.NetworkInfoImpl());
    gh.singleton<_i10.ApiExecution>(
        () => _i10.ApiExecution(gh<_i9.NetworkInfo>()));
    gh.singleton<_i11.SignInBloc>(
        () => _i11.SignInBloc(useCase: gh<_i8.AuthenticationUseCase>()));
    gh.singleton<_i12.SignUpBloc>(
        () => _i12.SignUpBloc(useCase: gh<_i8.AuthenticationUseCase>()));
    gh.factory<_i13.UserRemoteDataSource>(
        () => _i14.UserRemoteDatasourceImpl(gh<_i10.ApiExecution>()));
    gh.factory<_i15.UserRepository>(() => _i16.UserRepositoryImpl(
          gh<_i13.UserRemoteDataSource>(),
          gh<_i4.UserMapper>(),
        ));
    gh.singleton<_i17.UserUseCase>(
        () => _i17.UserUseCase(gh<_i15.UserRepository>()));
    gh.singleton<_i18.UserBloc>(
        () => _i18.UserBloc(useCase: gh<_i17.UserUseCase>()));
    return this;
  }
}
