import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mikesweb/app_theme.dart';
import 'package:mikesweb/models/app_state_manager.dart';
import 'package:mikesweb/navigation/app_router.dart';
import 'package:mikesweb/navigation/app_router_parser.dart';
import 'package:mikesweb/screens/home_screen.dart';
import 'package:mikesweb/utils/constants.dart';
import 'package:provider/provider.dart';

void main() async {
  await initHiveForFlutter();
  final HttpLink httpLink = HttpLink(AppConstants.serverUrl);

  final AuthLink authLink =
      AuthLink(getToken: () async => '');

  final Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(cache: GraphQLCache(store: HiveStore()), link: link));
  runApp( MikesWebApp(client: client));
}

class MikesWebApp extends StatefulWidget {
  final client;
  const MikesWebApp({Key? key, required this.client}) : super(key: key);

  @override
  State<MikesWebApp> createState() => _MikesWebAppState();
}

class _MikesWebAppState extends State<MikesWebApp> {
  final _appStateManager = AppStateManager();
  final routerParser = AppRouteParser();
  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(appStateManager: _appStateManager);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _appStateManager)
      ],
      child: Consumer<AppStateManager>(
        builder: (context, appStateManager, child) {
          ThemeData theme;
          if (appStateManager.darkMode) {
            theme = AppTheme.dark();
          } else {
            theme = AppTheme.light();
          }
          return GraphQLProvider(
            client: widget.client,
            child: MaterialApp.router(
              title: 'Mikes Web',
              debugShowCheckedModeBanner: false,
              theme: theme,
              backButtonDispatcher: RootBackButtonDispatcher(),
              routeInformationParser: routerParser,
              routerDelegate: _appRouter,
            ),
          );
        },
      ),
    );
  }
}
