import 'package:beamer/beamer.dart';
import 'package:flutter/widgets.dart';

import '../presentation/pages/home_page.dart';

/// {@template home_feature_route_template}
/// Location of the Home Module
/// {@endtemplate}
class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    return [
      const BeamPage(
        key: ValueKey("home_page"),
        title: "Home",
        name: "Home Page",
        child: HomePage(),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => [
        '/home',
      ];
}
