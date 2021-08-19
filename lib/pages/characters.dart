import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/bloc/rick_and_morty_bloc.dart';
import '../data/models/character.dart';
import '../widgets/character_item.dart';
import '../widgets/preloading_indicator.dart';

class CharactersPage extends StatefulWidget {
  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final List<Character> _list = [];

  @override
  void initState() {
    super.initState();
    context.read<RickAndMortyBloc>().add(CharactersFetchFirstPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: Center(
          child: BlocConsumer<RickAndMortyBloc, RickAndMortyState>(
            listener: (context, state) {
              if (state is CharactersNewPageError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Can't load new page"),
                ));
              }
              return;
            },
            builder: (context, state) {
              if (state is CharactersIsLoading) {
                return CircularProgressIndicator();
              } else if (state is CharactersFetched) {
                var list = state.list;
                _list.addAll(list);
                return _CharactersView(
                  list: _list,
                );
              }
              return _list.isEmpty
                  ? Text('smt went wrong')
                  : _CharactersView(
                      list: _list,
                    );
            },
          ),
        ),
      ),
    );
  }
}

class _CharactersView extends StatefulWidget {
  _CharactersView({
    Key? key,
    required this.list,
  }) : super(key: key);
  final List<Character> list;

  @override
  __CharactersViewState createState() => __CharactersViewState();
}

class __CharactersViewState extends State<_CharactersView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      context.read<RickAndMortyBloc>().add(CharactersFetchNewPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      controller: _scrollController,
      itemCount: widget.list.length,
      itemBuilder: (context, int index) {
        if (widget.list.length - 1 == index) {
          return Column(
            children: [
              CharacterItemWidget(item: widget.list[index]),
              const PreloadingIndicator()
            ],
          );
        }
        return CharacterItemWidget(item: widget.list[index]);
      },
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }
}
