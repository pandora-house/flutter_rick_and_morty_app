import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/bloc/rick_and_morty_bloc.dart';
import '../data/models/character.dart';
import '../data/models/locations.dart';
import '../widgets/resident_item.dart';

class LocationDetailPage extends StatelessWidget {
  LocationDetailPage({Key? key, required this.name}) : super(key: key);
  final String name;

  static const routeName = '/location_detail';

  @override
  Widget build(BuildContext context) {
    var location;
    var residents;
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: BlocBuilder<RickAndMortyBloc, RickAndMortyState>(
        builder: (context, state) {
          if (state is LocationIsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LocationFetched) {
            var item = state.item;
            location = item;
            var _list = state.residents;
            residents = _list;
            return _LocationsView(item: item, list: _list);
          }
          return location != null
              ? _LocationsView(item: location, list: residents)
              : Center(child: Text('smt went wrong'));
        },
      ),
    );
  }
}

class _LocationsView extends StatelessWidget {
  _LocationsView({Key? key, required this.item, required this.list})
      : super(key: key);
  final Locations item;
  final List<Character> list;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Type: ${item.type}'),
                      Text('Dimension: ${item.dimension}'),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
              child: Text('Residents'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, int index) =>
                    ResidentItemWidget(item: list[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
