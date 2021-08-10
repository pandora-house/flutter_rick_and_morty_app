import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/bloc/rick_and_morty_bloc.dart';
import '../data/models/episode.dart';
import '../pages/episode_detail.dart';

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
            onTap: () {
              Navigator.of(context).pushNamed(EpisodeDetailPage.routeName,
                  arguments: '${item.episode}: ${item.name}');
              context
                  .read<RickAndMortyBloc>()
                  .add(EpisodeFetchById(id: item.id!));
            },
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
