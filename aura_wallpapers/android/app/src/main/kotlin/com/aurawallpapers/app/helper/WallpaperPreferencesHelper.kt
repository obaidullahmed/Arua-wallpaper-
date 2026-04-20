package com.aurawallpapers.app.helper

import android.content.Context
import android.content.SharedPreferences

class WallpaperPreferencesHelper(context: Context) {

    private val preferences: SharedPreferences = context.getSharedPreferences("aura_wallpaper_preferences", Context.MODE_PRIVATE)

    companion object {
        private const val KEY_SOURCE_ASSET = "selected_wallpaper_source"
        private const val KEY_WALLPAPER_TYPE = "selected_wallpaper_type"
        private const val KEY_MOTION_SENSITIVITY = "motion_sensitivity"
        private const val KEY_BATTERY_SAVER = "battery_saver_enabled"
    }

    fun saveSelectedWallpaper(sourceAsset: String, wallpaperType: String) {
        preferences.edit()
            .putString(KEY_SOURCE_ASSET, sourceAsset)
            .putString(KEY_WALLPAPER_TYPE, wallpaperType)
            .apply()
    }

    fun getSelectedWallpaperSource(): String? {
        return preferences.getString(KEY_SOURCE_ASSET, null)
    }

    fun getSelectedWallpaperType(): String? {
        return preferences.getString(KEY_WALLPAPER_TYPE, null)
    }

    fun saveMotionSensitivity(value: Float) {
        preferences.edit().putFloat(KEY_MOTION_SENSITIVITY, value).apply()
    }

    fun getMotionSensitivity(): Float {
        return preferences.getFloat(KEY_MOTION_SENSITIVITY, 0.45f)
    }

    fun saveBatterySaver(enabled: Boolean) {
        preferences.edit().putBoolean(KEY_BATTERY_SAVER, enabled).apply()
    }

    fun isBatterySaverEnabled(): Boolean {
        return preferences.getBoolean(KEY_BATTERY_SAVER, false)
    }
}
