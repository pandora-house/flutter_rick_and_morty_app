import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/bloc/rick_and_morty_bloc.dart';
import '../data/models/character.dart';
import 'location_detail.dart';

class PersonageDetail extends StatelessWidget {
  PersonageDetail({Key? key, required this.id, required this.name})
      : super(key: key);
  final String name;
  final int id;

  static const routeName = '/character_detail';

  @override
  Widget build(BuildContext context) {
    context.read<RickAndMortyBloc>().add(PersonageFetch(id: id));
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: BlocBuilder<RickAndMortyBloc, RickAndMortyState>(
          builder: (context, state) {
            if (state is PersonageIsLoading) {
              return CircularProgressIndicator();
            } else if (state is PersonageFetched) {
              var item = state.personage;
              return Column(
                children: [
                  _PersonageCard(item: item),
                  SizedBox(
                    height: 16,
                  ),
                  _PersonageOption(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(LocationDetailPage.routeName,
                              arguments: item.location!.name)
                          .then((value) => context
                              .read<RickAndMortyBloc>()
                              .add(PersonageFetch(id: id)));
                      context
                          .read<RickAndMortyBloc>()
                          .add(LocationFetchByUrl(url: item.location!.url!));
                    },
                    title: 'Location',
                  ),
                  _PersonageOption(
                    onTap: () {},
                    title: 'Episodes',
                  ),
                ],
              );
            }
            return Text('Smt went wrong');
          },
        ),
      ),
    );
  }
}

class _PersonageCard extends StatelessWidget {
  _PersonageCard({Key? key, required this.item}) : super(key: key);
  final Character item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 24),
            child: SizedBox(
                width: 200,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    child: Image.network(item.image!))),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        margin: const EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                            color: item.status! == 'Alive'
                                ? Colors.green
                                : Colors.red,
                            shape: BoxShape.circle),
                      ),
                      Text(
                        item.status!,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        ' - ${item.species}',
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Origin location:',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontSize: 14),
                  ),
                  Text(
                    item.origin!.name!,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Last location:',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontSize: 14),
                  ),
                  Text(
                    item.location!.name!,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonageOption extends StatelessWidget {
  _PersonageOption({Key? key, required this.title, required this.onTap})
      : super(key: key);
  final Function() onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Ink(
            color: Colors.white,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      title,
                      style: Theme.of(context).textTheme.subtitle1,
                    )),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 0.7,
            thickness: 0.7,
          )
        ],
      ),
    );
  }
}
