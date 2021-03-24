import 'package:chat_real_time_app/data/auth_repository.dart';
import 'package:chat_real_time_app/data/image_picker_repository.dart';
import 'package:chat_real_time_app/data/local/auth_local_impl.dart';
import 'package:chat_real_time_app/data/local/image_picker_impl.dart';
import 'package:chat_real_time_app/data/local/persistent_storage_local_impl.dart';
import 'package:chat_real_time_app/data/local/stream_api_local_impl.dart';
import 'package:chat_real_time_app/data/local/upload_storage_local_impl.dart';
import 'package:chat_real_time_app/data/persistent_storage_repository.dart';
import 'package:chat_real_time_app/data/prod/auth_impl.dart';
import 'package:chat_real_time_app/data/prod/persistent_storage_impl.dart';
import 'package:chat_real_time_app/data/prod/stream_api_impl.dart';
import 'package:chat_real_time_app/data/prod/upload_storage_impl.dart';
import 'package:chat_real_time_app/data/stream_api_repository.dart';
import 'package:chat_real_time_app/data/upload_storage_repository.dart';
import 'package:chat_real_time_app/domain/usecases/create_group_case.dart';
import 'package:chat_real_time_app/domain/usecases/login_use_case.dart';
import 'package:chat_real_time_app/domain/usecases/logout_use_case.dart';
import 'package:chat_real_time_app/domain/usecases/profile_sign_in_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

List<RepositoryProvider> buildRepositories(StreamChatClient client) {
  return [
    RepositoryProvider<StreamApiRepository>(
        create: (_) => StreamApiImpl(client)),
    RepositoryProvider<PersistentStorageRepository>(
        create: (_) => PersistenceStorageImpl()),
    RepositoryProvider<AuthRepository>(create: (_) => AuthImpl()),
    RepositoryProvider<UploadStorageRepository>(
        create: (_) => UploadStorageImpl()),
    RepositoryProvider<ImagePickerRepository>(create: (_) => ImagePickerImpl()),
    RepositoryProvider<ProfileSignInUseCase>(
      create: (context) =>
          ProfileSignInUseCase(context.read(), context.read(), context.read()),
    ),
    RepositoryProvider<CreateGroupUseCase>(
        create: (context) =>
            CreateGroupUseCase(context.read(), context.read())),
    RepositoryProvider<LogoutUseCase>(
        create: (context) => LogoutUseCase(context.read(), context.read())),
    RepositoryProvider<LoginUseCase>(
        create: (context) => LoginUseCase(context.read(), context.read())),
  ];
}
