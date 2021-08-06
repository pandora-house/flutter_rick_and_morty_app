import 'package:flutter/cupertino.dart';

class LocationDetailPage extends StatelessWidget {
  LocationDetailPage({Key? key, required this.id, required this.name})
      : super(key: key);
  final String name;
  final int id;

  static const routeName = '/location_detail';

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
