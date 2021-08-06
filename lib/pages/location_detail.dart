import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/resident_item.dart';

import '../data/bloc/rick_and_morty_bloc.dart';

class LocationDetailPage extends StatelessWidget {
  LocationDetailPage({Key? key, required this.name}) : super(key: key);
  final String name;

  static const routeName = '/location_detail';

  @override
  Widget build(BuildContext context) {
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
              var item = state.item;
              var _list = state.residents;
              return Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            ],),
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
                          itemCount: _list.length,
                          itemBuilder: (context, int index) =>
                              ResidentItemWidget(item: _list[index]),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Text('smt went wrong');
          },
        ),
      ),
    );
  }
}
