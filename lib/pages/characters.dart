import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/bloc/rick_and_morty_bloc.dart';
import '../data/models/character.dart';
import '../widgets/character_item.dart';

class CharactersPage extends StatelessWidget {
  final List<Character> _characters = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Characters'),
      ),
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
                _characters.addAll(list);
                return ListView.builder(
                  controller: _scrollController
                    ..addListener(() {
                      if (_scrollController.offset ==
                          _scrollController.position.maxScrollExtent) {
                        context
                            .read<RickAndMortyBloc>()
                            .add(CharactersFetchNewPage());
                      }
                    }),
                  itemCount: _characters.length,
                  itemBuilder: (context, int index) =>
                      CharacterItem(item: _characters[index]),
                );
              }
              return _characters.isEmpty
                  ? Text('smt went wrong')
                  : ListView.builder(
                      itemCount: _characters.length,
                      itemBuilder: (context, int index) =>
                          CharacterItem(item: _characters[index]),
                    );
            },
          ),
        ),
      ),
    );
  }
}
