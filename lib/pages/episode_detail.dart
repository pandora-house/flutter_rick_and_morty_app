import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/bloc/rick_and_morty_bloc.dart';
import '../data/models/character.dart';
import '../data/models/episode.dart';
import '../widgets/sub_item.dart';
import 'personage_detail.dart';

class EpisodeDetailPage extends StatelessWidget {
  EpisodeDetailPage({Key? key, required this.name}) : super(key: key);
  final String name;

  static const routeName = '/episode_detail';

  @override
  Widget build(BuildContext context) {
    var episode;
    var characters;
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: BlocBuilder<RickAndMortyBloc, RickAndMortyState>(
        builder: (context, state) {
          if (state is EpisodeIsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is EpisodeFetched) {
            var item = state.item;
            episode = item;
            var _list = state.characters;
            characters = _list;
            return _EpisodesView(item: item, list: _list);
          }
          return episode != null
              ? _EpisodesView(item: episode, list: characters)
              : Center(child: Text('smt went wrong'));
        },
      ),
    );
  }
}

class _EpisodesView extends StatelessWidget {
  _EpisodesView({Key? key, required this.item, required this.list})
      : super(key: key);
  final Episode item;
  final List<Character> list;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
              child: Text('Characters'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, int index) {
                  return SubItemWidget(
                    name: list[index].name!,
                    onTap: () {
                      Navigator.of(context).pushNamed(PersonageDetail.routeName,
                          arguments: {'id': list[index].id, 'name': list[index].name});
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
