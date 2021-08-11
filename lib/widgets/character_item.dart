import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/models/character.dart';
import '../pages/personage_detail.dart';

class CharacterItemWidget extends StatelessWidget {
  CharacterItemWidget({Key? key, required this.item}) : super(key: key);
  final Character item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(PersonageDetail.routeName,
            arguments: {'id': item.id!, 'name': item.name});
      },
      child: Card(
        child: Row(
          children: [
            SizedBox(
                height: 110,
                width: 110,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    child: Image.network(item.image!))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 142,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name!,
                      overflow: TextOverflow.clip,
                      softWrap: false,
                      style: Theme.of(context).textTheme.headline6,
                    ),
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
                          overflow: TextOverflow.clip,
                          softWrap: false,
                          style: Theme.of(context).textTheme.subtitle1,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Last location:',
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 14),
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      item.location!.name!,
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.clip,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
