import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mooncake/dependency_injection/dependency_injection.dart';
import 'package:mooncake/notifications/notifications.dart';
import 'package:mooncake/ui/ui.dart';

/// Represents the overall application that is run
class PostsApp extends StatefulWidget {
  @override
  _PostsAppState createState() => _PostsAppState();
}

class _PostsAppState extends State<PostsApp> {
  NotificationsManager _notificationsManager;

  @override
  void initState() {
    super.initState();
    _notificationsManager = NotificationsManager.create(context);
    _notificationsManager.init();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MnemonicInputBloc>(
          create: (_) => MnemonicInputBloc(),
        ),
        BlocProvider<RecoverAccountBloc>(
          create: (context) => RecoverAccountBloc.create(context),
        ),
        BlocProvider<GenerateMnemonicBloc>(
          create: (context) => GenerateMnemonicBloc.create(context),
        ),
        BlocProvider<PostsListBloc>(
          create: (_) => PostsListBloc.create(syncPeriod: 30)..add(LoadPosts()),
        ),
        BlocProvider<NotificationsBloc>(
          create: (_) => NotificationsBloc.create()..add(LoadNotifications()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: PostsKeys.navigatorKey,
        title: PostsLocalizations().appTitle,
        theme: PostsTheme.theme,
        localizationsDelegates: [
          FlutterBlocLocalizationsDelegate(),
        ],
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: Injector.get()),
        ],
        routes: {
          PostsRoutes.home: (context) => SplashScreen(),
          PostsRoutes.recoverAccount: (context) => RecoverAccountScreen(),
          PostsRoutes.createAccount: (context) => GenerateMnemonicScreen(),
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _notificationsManager.dispose();
  }
}
