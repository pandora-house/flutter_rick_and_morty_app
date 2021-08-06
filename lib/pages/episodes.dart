import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/bloc/rick_and_morty_bloc.dart';
import '../data/models/episode.dart';
import '../widgets/episode_item.dart';

class EpisodesPage extends StatefulWidget {
  @override
  _EpisodesPageState createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  final List<Episode> _list = [];

  @override
  void initState() {
    super.initState();
    context.read<RickAndMortyBloc>().add(EpisodesFetchFirstPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Episodes'),
        ),
        body: Scrollbar(
            child: Center(
          child: BlocConsumer<RickAndMortyBloc, RickAndMortyState>(
            listener: (context, state) {
              if (state is EpisodesNewPageError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Can't load new page"),
                ));
              }
              return;
            },
            builder: (context, state) {
              if (state is EpisodesIsLoading) {
                return CircularProgressIndicator();
              } else if (state is EpisodesFetched) {
                var list = state.list;
                _list.addAll(list);
                return _EpisodesView(list: _list);
              }
              return _list.isEmpty
                  ? Text('smt went wrong')
                  : _EpisodesView(list: _list);
            },
          ),
        )));
  }
}

class _EpisodesView extends StatelessWidget {
  _EpisodesView({Key? key, required this.list}) : super(key: key);
  final List<Episode> list;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController
        ..addListener(() {
          if (_scrollController.offset ==
              _scrollController.position.maxScrollExtent) {
            context.read<RickAndMortyBloc>().add(EpisodesFetchNewPage());
          }
        }),
      itemCount: list.length,
      itemBuilder: (context, int index) => EpisodeItemWidget(item: list[index]),
    );
  }
}
