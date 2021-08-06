import 'package:flutter/cupertino.dart';

class EpisodeDetailPage extends StatelessWidget {
  EpisodeDetailPage({Key? key, required this.id, required this.name})
      : super(key: key);
  final String name;
  final int id;

  static const routeName = '/episode_detail';

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
