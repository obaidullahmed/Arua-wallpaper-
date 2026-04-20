import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/settings_service.dart';

final settingsServiceProvider = Provider<SettingsService>((ref) {
  return SettingsService();
});

class SettingsState {
  final bool motionEnabled;
  final bool batterySaverEnabled;
  final double motionSensitivity;
  final bool isLoading;

  const SettingsState({
    required this.motionEnabled,
    required this.batterySaverEnabled,
    required this.motionSensitivity,
    required this.isLoading,
  });

  factory SettingsState.initial() {
    return const SettingsState(
      motionEnabled: true,
      batterySaverEnabled: false,
      motionSensitivity: 0.45,
      isLoading: true,
    );
  }

  SettingsState copyWith({
    bool? motionEnabled,
    bool? batterySaverEnabled,
    double? motionSensitivity,
    bool? isLoading,
  }) {
    return SettingsState(
      motionEnabled: motionEnabled ?? this.motionEnabled,
      batterySaverEnabled: batterySaverEnabled ?? this.batterySaverEnabled,
      motionSensitivity: motionSensitivity ?? this.motionSensitivity,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier(this._service) : super(SettingsState.initial()) {
    _loadSettings();
  }

  final SettingsService _service;

  Future<void> _loadSettings() async {
    final settings = await _service.loadSettings();
    state = state.copyWith(
      motionEnabled: settings.motionEnabled,
      batterySaverEnabled: settings.batterySaverEnabled,
      motionSensitivity: settings.motionSensitivity,
      isLoading: false,
    );
  }

  Future<void> updateMotionEnabled(bool value) async {
    state = state.copyWith(motionEnabled: value);
    await _service.saveMotionEnabled(value);
  }

  Future<void> updateBatterySaverEnabled(bool value) async {
    state = state.copyWith(batterySaverEnabled: value);
    await _service.saveBatterySaverEnabled(value);
  }

  Future<void> updateMotionSensitivity(double value) async {
    state = state.copyWith(motionSensitivity: value);
    await _service.saveMotionSensitivity(value);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier(ref.read(settingsServiceProvider));
});
