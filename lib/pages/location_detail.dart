import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/bloc/rick_and_morty_bloc.dart';

class LocationDetailPage extends StatelessWidget {
  LocationDetailPage({Key? key, required this.name})
      : super(key: key);
  final String name;

  static const routeName = '/location_detail';

  @override
  Widget build(BuildContext context) {
    // context.read<RickAndMortyBloc>().add(LocationFetchById(id: id));
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: BlocBuilder<RickAndMortyBloc, RickAndMortyState>(
          builder: (context, state) {
            if (state is LocationIsLoading) {
              return CircularProgressIndicator();
            } else if (state is LocationFetched) {
              var data = state.item;
              return Container();
            }
            return Text('smt went wrong');
          },
        ),
      ),
    );
  }
}
