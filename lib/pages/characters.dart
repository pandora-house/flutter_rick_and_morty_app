import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/bloc/rick_and_morty_bloc.dart';
import '../data/models/character.dart';
import '../widgets/character_item.dart';

class CharactersPage extends StatelessWidget {
  final List<Character> _list = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    context.read<RickAndMortyBloc>().add(CharactersFetchFirstPage());
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
                _list.addAll(list);
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
                  itemCount: _list.length,
                  itemBuilder: (context, int index) =>
                      CharacterItemWidget(item: _list[index]),
                );
              }
              return _list.isEmpty
                  ? Text('smt went wrong')
                  : ListView.builder(
                      itemCount: _list.length,
                      itemBuilder: (context, int index) =>
                          CharacterItemWidget(item: _list[index]),
                    );
            },
          ),
        ),
      ),
    );
  }
}
