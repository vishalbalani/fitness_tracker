import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stream_controller.g.dart';

@Riverpod(keepAlive: true)
class StreamController extends _$StreamController {
  @override
  bool build() {
    return true;
  }

  updateState(bool value) {
    state = value;
  }
}
