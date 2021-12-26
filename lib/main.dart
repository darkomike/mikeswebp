import 'package:flutter/material.dart';
import 'package:mikesweb/app_theme.dart';
import 'package:mikesweb/models/app_state_manager.dart';
import 'package:mikesweb/navigation/app_router.dart';
import 'package:mikesweb/navigation/app_router_parser.dart';
import 'package:mikesweb/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MikesWebApp());
}

class MikesWebApp extends StatefulWidget {
  const MikesWebApp({Key? key}) : super(key: key);

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
       ChangeNotifierProvider(create: (context)=> _appStateManager)
     ],
     child: Consumer<AppStateManager>(
       builder: (context, appStateManager, child){

         ThemeData theme;
         if (appStateManager.darkMode) {
           theme = AppTheme.dark();
         } else {
           theme = AppTheme.light();
         }
         return MaterialApp.router(
           title: 'Mikes Web',
           debugShowCheckedModeBanner: false,
           theme: theme ,
           backButtonDispatcher: RootBackButtonDispatcher(),
           routeInformationParser: routerParser,
           routerDelegate: _appRouter,

         );
       },
     ),
   );
  }
}


