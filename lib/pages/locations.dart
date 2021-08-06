import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/bloc/rick_and_morty_bloc.dart';
import '../data/models/locations.dart';
import '../widgets/location_item.dart';

class LocationsPage extends StatelessWidget {
  final List<Locations> _list = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    context.read<RickAndMortyBloc>().add(LocationsFetchFirstPage());
    return Scaffold(
        appBar: AppBar(
          title: Text('Locations'),
        ),
        body: Scrollbar(
            child: Center(
              child: BlocConsumer<RickAndMortyBloc, RickAndMortyState>(
                listener: (context, state) {
                  if (state is LocationsNewPageError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Can't load new page"),
                    ));
                  }
                  return;
                },
                builder: (context, state) {
                  if (state is LocationsIsLoading) {
                    return CircularProgressIndicator();
                  } else if (state is LocationsFetched) {
                    var list = state.list;
                    _list.addAll(list);
                    return ListView.builder(
                      controller: _scrollController
                        ..addListener(() {
                          if (_scrollController.offset ==
                              _scrollController.position.maxScrollExtent) {
                            context
                                .read<RickAndMortyBloc>()
                                .add(LocationsFetchNewPage());
                          }
                        }),
                      itemCount: _list.length,
                      itemBuilder: (context, int index) =>
                          LocationItemWidget(item: _list[index]),
                    );
                  }
                  return _list.isEmpty
                      ? Text('smt went wrong')
                      : ListView.builder(
                    itemCount: _list.length,
                    itemBuilder: (context, int index) =>
                        LocationItemWidget(item: _list[index],),
                  );
                },
              ),
            )));
  }
}