import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/bloc/rick_and_morty_bloc.dart';
import '../data/models/episode.dart';
import '../widgets/episode_item.dart';
import '../widgets/preloading_indicator.dart';

class EpisodesPage extends StatefulWidget {
  @override
  _EpisodesPageState createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  final List<Episode> _list = [];

  bool newPageError = false;

  @override
  void initState() {
    super.initState();
    newPageError = false;
    context.read<RickAndMortyBloc>().add(EpisodesFetchFirstPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(
            child: Center(
      child: BlocConsumer<RickAndMortyBloc, RickAndMortyState>(
        listener: (context, state) {
          if (state is EpisodesNewPageError) {
            newPageError = true;

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
            if (!newPageError) _list.addAll(list);
            return _EpisodesView(list: _list, loadError: newPageError,);
          }
          return _list.isEmpty
              ? SizedBox.shrink()
              : _EpisodesView(list: _list, loadError: newPageError,);
        },
      ),
    )));
  }
}

class _EpisodesView extends StatefulWidget {
  _EpisodesView({Key? key, required this.list, required this.loadError}) : super(key: key);
  final List<Episode> list;
  final bool loadError;

  @override
  __EpisodesViewState createState() => __EpisodesViewState();
}

class __EpisodesViewState extends State<_EpisodesView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      context.read<RickAndMortyBloc>().add(EpisodesFetchNewPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.list.length,
      itemBuilder: (context, int index) {
        if (widget.list.length - 1 == index) {
          return Column(
            children: [
              EpisodeItemWidget(item: widget.list[index]),
              !widget.loadError ? const PreloadingIndicator() : Container()
            ],
          );
        }
        return EpisodeItemWidget(item: widget.list[index]);
      },
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }
}
