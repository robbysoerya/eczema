import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BasePage extends ConsumerStatefulWidget {
  const BasePage({super.key});

}

abstract class BaseState<Page extends BasePage> extends ConsumerState<Page> {
  String screenName();
}
