import 'package:flutter/material.dart';

import '../data/models/character.dart';
import '../pages/personage_detail.dart';

class ResidentItemWidget extends StatelessWidget {
  ResidentItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);
  final Character item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Ink(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(PersonageDetail.routeName,
                  arguments: {'id': item.id, 'name': item.name});
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
              child: Row(
                children: [
                  Expanded(child: Text(item.name!)),
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
    );
  }
}
