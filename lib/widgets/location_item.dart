import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/bloc/rick_and_morty_bloc.dart';
import '../data/models/locations.dart';
import '../pages/location_detail.dart';

class LocationItemWidget extends StatelessWidget {
  LocationItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);
  final Locations item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Ink(
          color: Colors.white,
          child: ListTile(
            title: new Text(item.name!, overflow: TextOverflow.ellipsis),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Text(
                  'Type: ${item.type}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                new Text(
                  'Dimension: ${item.dimension}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(LocationDetailPage.routeName,
                  arguments: item.name);
              context
                  .read<RickAndMortyBloc>()
                  .add(LocationFetchById(id: item.id!));
            },
            contentPadding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
          ),
        ),
        Divider(
          height: 0.7,
          thickness: 0.7,
        )
      ],
    );
  }
}
