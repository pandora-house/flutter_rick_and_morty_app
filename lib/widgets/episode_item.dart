import 'package:flutter/material.dart';
import '../data/models/episode.dart';

class EpisodeItemWidget extends StatelessWidget {
  EpisodeItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);
  final Episode item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Ink(
          color: Colors.white,
          child: ListTile(
            title: new Text(item.name!, overflow: TextOverflow.ellipsis),
            subtitle: new Text(
              item.episode!,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
            onTap: () {},
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
        Divider(
          height: 0.7,
          thickness: 0.7,
        )
      ],
    );
  }
}
