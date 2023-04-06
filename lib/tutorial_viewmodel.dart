import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_shokai/tutorial_viewmodel_state.dart';

const _startdayKey = 'startdayKey';
const _shouldShowDailyView1 = 'shouldShowDailyView1';

final tutorialViewModel = StateNotifierProvider<TutorialViewModel, TutorialViewModelState>(
        (ref) => TutorialViewModel());

class TutorialViewModel extends StateNotifier<TutorialViewModelState>{
  TutorialViewModel() : super(TutorialViewModelState()) {
  }

  ///sharedPreferencesをインスタンスを取得
  Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }
  Future<bool> isFirstLaunch () async{
    SharedPreferences _sharedPreferences = await getInstance();
    var firstday = _sharedPreferences.getString(_startdayKey) ?? "";
    return firstday.isEmpty;
  }

  /// 使い始めた日を保存する
  void checkFirstLaunchDate() async{
    SharedPreferences _sharedPreferences = await getInstance();
    var firstday = _sharedPreferences.getString(_startdayKey) ?? "";

    // 初回起動の場合は今日を初回起動日として保存
    if (firstday.isEmpty) {
      _sharedPreferences.setString(
          _startdayKey, DateTime.now().toString());
      state = state.copyWith(shouldShowDailyView: true,shouldShowDailyView2: true,shouldShowDailyView3: true);
      _sharedPreferences.setBool(_shouldShowDailyView1, true);
      print('----------初回起動を保存---------');
      print(firstday);
    } else {
      print('----------初回起動じゃないよ-------');
      state = state.copyWith(shouldShowDailyView: _sharedPreferences.getBool(_shouldShowDailyView1) ?? true,shouldShowDailyView2: true,shouldShowDailyView3: true);
      print(firstday);
    }
  }

  void finishShow1() async{
    SharedPreferences _sharedPreferences = await getInstance();
    state = state.copyWith(shouldShowDailyView: false);
    _sharedPreferences.setBool(_shouldShowDailyView1, false);
  }
}