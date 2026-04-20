import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/app_constants.dart';

class SettingsData {
  final bool motionEnabled;
  final bool batterySaverEnabled;
  final double motionSensitivity;

  const SettingsData({
    required this.motionEnabled,
    required this.batterySaverEnabled,
    required this.motionSensitivity,
  });

  SettingsData copyWith({
    bool? motionEnabled,
    bool? batterySaverEnabled,
    double? motionSensitivity,
  }) {
    return SettingsData(
      motionEnabled: motionEnabled ?? this.motionEnabled,
      batterySaverEnabled: batterySaverEnabled ?? this.batterySaverEnabled,
      motionSensitivity: motionSensitivity ?? this.motionSensitivity,
    );
  }
}

class SettingsService {
  Future<SettingsData> loadSettings() async {
    final preferences = await SharedPreferences.getInstance();
    final motionEnabled = preferences.getBool(AppConstants.preferenceMotionEnabledKey) ?? true;
    final batterySaverEnabled = preferences.getBool(AppConstants.preferenceBatterySaverKey) ?? false;
    final motionSensitivity = preferences.getDouble(AppConstants.preferenceSensitivityKey) ?? AppConstants.defaultMotionSensitivity;

    return SettingsData(
      motionEnabled: motionEnabled,
      batterySaverEnabled: batterySaverEnabled,
      motionSensitivity: motionSensitivity,
    );
  }

  Future<void> saveMotionEnabled(bool isEnabled) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(AppConstants.preferenceMotionEnabledKey, isEnabled);
  }

  Future<void> saveBatterySaverEnabled(bool value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(AppConstants.preferenceBatterySaverKey, value);
  }

  Future<void> saveMotionSensitivity(double value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setDouble(AppConstants.preferenceSensitivityKey, value);
  }
}
