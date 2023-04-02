import 'package:freezed_annotation/freezed_annotation.dart';

part 'tutorial_viewmodel_state.freezed.dart';

@freezed
class TutorialViewModelState with _$TutorialViewModelState {
  const factory TutorialViewModelState({
    @Default(false) bool shouldShowDailyView,
    @Default(false) bool shouldShowDailyView2,
    @Default(false) bool shouldShowDailyView3,
  }) = _TutorialViewModelState;
}
