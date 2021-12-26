import 'package:flutter/cupertino.dart';
import 'package:mikesweb/navigation/app_link.dart';

class AppRouteParser extends RouteInformationParser<AppLink>{
  @override
  Future<AppLink> parseRouteInformation(RouteInformation routeInformation) async {
    // TODO: implement parseRouteInformation
    final link = AppLink.fromLocation(routeInformation.location);
    return link;
  }

  @override
  RouteInformation restoreRouteInformation(AppLink appLink) {
    final location = appLink.toLocation();
    return RouteInformation(location: location);
  }
}