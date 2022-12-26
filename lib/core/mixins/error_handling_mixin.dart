import 'package:eczema/core/core.dart';
import 'package:flutter/material.dart';

mixin ErrorHandlingErrorMixin<Page extends BasePage> on BaseState<Page> {
  @override
  Widget errorWidget(Failure failure) {
    if (failure is ServerFailure) {
      return Container();
    } else if (failure is SocketFailure) {
      return Container();
    } else {
      return Container();
    }
  }
}
