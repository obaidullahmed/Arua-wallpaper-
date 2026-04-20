import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: settingsState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                children: [
                  SwitchListTile(
                    title: const Text('Enable motion wallpaper', style: TextStyle(color: Colors.white)),
                    subtitle: const Text('Use subtle parallax motion based on device sensors.', style: TextStyle(color: Colors.white70)),
                    value: settingsState.motionEnabled,
                    activeColor: Colors.cyan,
                    onChanged: settingsNotifier.updateMotionEnabled,
                  ),
                  const Divider(color: Colors.white12),
                  SwitchListTile(
                    title: const Text('Battery saver mode', style: TextStyle(color: Colors.white)),
                    subtitle: const Text('Reduce motion updates while wallpaper is active.', style: TextStyle(color: Colors.white70)),
                    value: settingsState.batterySaverEnabled,
                    activeColor: Colors.cyan,
                    onChanged: settingsNotifier.updateBatterySaverEnabled,
                  ),
                  const Divider(color: Colors.white12),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text('Motion sensitivity', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
                  ),
                  Slider(
                    value: settingsState.motionSensitivity,
                    onChanged: settingsNotifier.updateMotionSensitivity,
                    min: 0.1,
                    max: 1.0,
                    divisions: 9,
                    activeColor: Colors.cyan,
                    inactiveColor: Colors.white24,
                  ),
                  const SizedBox(height: 24),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('About Aura Wallpapers', style: TextStyle(color: Colors.white)),
                    subtitle: const Text('Premium dynamic live wallpaper engine with motion and video support.', style: TextStyle(color: Colors.white70)),
                    trailing: const Icon(Icons.info_outline, color: Colors.white70),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Aura Wallpapers uses local bundled wallpaper assets and a native Android live wallpaper engine. Apply any wallpaper directly to your device home screen through the system live wallpaper flow.',
                    style: TextStyle(color: Colors.white60),
                  ),
                ],
              ),
      ),
    );
  }
}
