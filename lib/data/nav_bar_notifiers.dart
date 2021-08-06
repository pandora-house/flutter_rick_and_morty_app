import 'package:flutter/cupertino.dart';

class NavBarNotifier with ChangeNotifier {
  ValueNotifier<int> index = ValueNotifier<int>(0);
}