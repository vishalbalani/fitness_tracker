import 'package:fitness_tracker/model/fitness_data_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fitness_data_provider.g.dart';

@Riverpod(keepAlive: true)
class FitnessData extends _$FitnessData {
  @override
  FitnessDataModel? build() {
    return null;
  }

  updateState(FitnessDataModel model) {
    state = model;
  }
}
