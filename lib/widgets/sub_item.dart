import 'package:flutter/material.dart';

class SubItemWidget extends StatelessWidget {
  SubItemWidget({Key? key, required this.name, required this.onTap})
      : super(key: key);
  final String name;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    name,
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
    );
  }
}
