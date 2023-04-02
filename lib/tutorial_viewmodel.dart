import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_shokai/tutorial_viewmodel_state.dart';

const _startdayKey = 'startdayKey';

final tutorialViewModel = StateNotifierProvider<TutorialViewModel, TutorialViewModelState>(
        (ref) => TutorialViewModel());

class TutorialViewModel extends StateNotifier<TutorialViewModelState>{
  TutorialViewModel() : super(TutorialViewModelState()) {
  }

  ///sharedPreferencesをインスタンスを取得
  Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }

  /// 使い始めた日を保存する
  void checkFirstLaunchDate() async{
    SharedPreferences _sharedPreferences = await getInstance();
    var firstday = _sharedPreferences.getString(_startdayKey) ?? "";
    // 初回起動の場合は今日を初回起動日として保存
    if (firstday.isEmpty) {
      _sharedPreferences.setString(
          _startdayKey, firstday);
      state = state.copyWith(shouldShowDailyView: true,shouldShowDailyView2: true,shouldShowDailyView3: true);
      print('----------初回起動を保存---------');
      print(firstday);
    } else {
      print('----------初回起動じゃないよ-------');
      print(firstday);
    }
  }
}