import 'package:chat_real_time_app/data/persistent_storage_repository.dart';
import 'package:chat_real_time_app/dependencies.dart';
import 'package:chat_real_time_app/ui/app_theme_cubit.dart';
import 'package:chat_real_time_app/ui/splash/splash_view.dart';
import 'package:chat_real_time_app/ui/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _streamChatClient =
      StreamChatClient('b5z8p92we559', logLevel: Level.INFO);

  void _fakeUser() async {
    await _streamChatClient.disconnect();
    _streamChatClient.connectUser(
        User(id: 'diego'), _streamChatClient.devToken('diego'));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    //_fakeUser();
    return MultiRepositoryProvider(
      providers: buildRepositories(_streamChatClient),
      child: BlocProvider(
        create: (context) => AppThemeCubit(context.read())..init(),
        child: BlocBuilder<AppThemeCubit, bool>(builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'OmniChat',
            home: SplashView(),
            theme: snapshot ? Themes.themeDark : Themes.themeLight,
            builder: (context, child) {
              return StreamChat(
                child: child,
                client: _streamChatClient,
                streamChatThemeData:
                    StreamChatThemeData.fromTheme(Theme.of(context)).copyWith(
                      
                      ownMessageTheme: MessageTheme(
                        messageBackgroundColor: Theme.of(context).accentColor,
                        messageText: TextStyle(color: Colors.white)
                      )
                    ),
              );
            },
          );
        }),
      ),
    );
  }
}
