import 'package:chat/layers/data/repositories/message_repository_impl.dart';
import 'package:chat/layers/data/sources/local/chat_local_data_source.dart';
import 'package:chat/layers/data/sources/local/message_local_data_source.dart';
import 'package:chat/layers/domain/repositories/message_repository.dart';
import 'package:chat/layers/domain/usecase/message/add_local_message_usecase.dart';
import 'package:chat/layers/domain/usecase/message/delete_local_message_usecase.dart';
import 'package:chat/layers/domain/usecase/message/get_local_messages_usecase.dart';
import 'package:chat/layers/presentation/chat/notifiers/chat_detail_notifier.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ===================== NOTIFIER ========================
  // Chat
  sl.registerFactory(() => ChatDetailNotifier(
    localMessagesUsecase: sl(),
    addLocalMessageUsecase: sl(),
    deleteLocalMessageUsecase: sl()
  ));

  // ===================== USECASES ========================
  // Message
  sl.registerLazySingleton(() => GetLocalMessagesUsecase(sl()));
  sl.registerLazySingleton(() => AddLocalMessageUsecase(sl()));
  sl.registerLazySingleton(() => DeleteLocalMessageUsecase(sl()));

  // ===================== REPOSITORIES ========================
  // Message
  sl.registerLazySingleton<MessageRepository>(
        () => MessageRepositoryImpl(localDataSource: sl()),
  );

  // ===================== SOURCES ========================
  // Chat
  sl.registerLazySingleton<ChatLocalDataSource>(
        () => ChatLocalDataSourceImpl(),
  );

  // Message
  sl.registerLazySingleton<MessageLocalDataSource>(
        () => MessageLocalDataSourceImpl(),
  );
}