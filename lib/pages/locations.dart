import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/bloc/rick_and_morty_bloc.dart';
import '../data/models/locations.dart';
import '../widgets/location_item.dart';
import '../widgets/preloading_indicator.dart';

class LocationsPage extends StatefulWidget {
  @override
  _LocationsPageState createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  final List<Locations> _list = [];

  @override
  void initState() {
    super.initState();
    context.read<RickAndMortyBloc>().add(LocationsFetchFirstPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            return _LocationsView(list: _list);
          }
          return _list.isEmpty
              ? Text('smt went wrong')
              : _LocationsView(list: _list);
        },
      ),
    )));
  }
}

class _LocationsView extends StatefulWidget {
  _LocationsView({Key? key, required this.list}) : super(key: key);
  final List<Locations> list;

  @override
  __LocationsViewState createState() => __LocationsViewState();
}

class __LocationsViewState extends State<_LocationsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      context.read<RickAndMortyBloc>().add(LocationsFetchNewPage());
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
              LocationItemWidget(item: widget.list[index]),
              const PreloadingIndicator()
            ],
          );
        }
        return LocationItemWidget(item: widget.list[index]);
      },
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }
}
