import 'package:provider/provider.dart';

import '../model/item.dart';
import '../provider/frozen_provider.dart';
import '../provider/normal_provider.dart';
import '../provider/refrigerated_provider.dart';

class Controller {
  late FrozenProvider _frozenProvider;
  late NormalProvider _normalProvider;
  late RefrigeratedProvider _refrigeratedProvider;

  void initController(context) {
    print("initController");
    _frozenProvider = Provider.of<FrozenProvider>(context, listen: false);
    _normalProvider = Provider.of<NormalProvider>(context, listen: false);
    _refrigeratedProvider = Provider.of<RefrigeratedProvider>(context, listen: false);
    print("initController finish");
  }

  void insertItem(Item item) {
    if (item.storageCategory == '냉장') {
      _refrigeratedProvider.insertItem(item);
      return;
    }
    if (item.storageCategory == '실온') {
      _normalProvider.insertItem(item);
      return;
    }
    if (item.storageCategory == '냉동') {
      _frozenProvider.insertItem(item);
      return;
    }
  }
}
