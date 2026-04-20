package com.aurawallpapers.app.channel

import android.app.WallpaperManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import com.aurawallpapers.app.helper.WallpaperPreferencesHelper
import com.aurawallpapers.app.service.ParallaxLiveWallpaperService
import com.aurawallpapers.app.service.VideoLiveWallpaperService

class WallpaperMethodChannelHandler(
    context: Context,
    messenger: BinaryMessenger,
) : MethodChannel.MethodCallHandler {

    private val channel: MethodChannel = MethodChannel(messenger, "com.aurawallpapers/wallpaper_channel")
    private val applicationContext = context.applicationContext
    private val preferencesHelper = WallpaperPreferencesHelper(applicationContext)

    init {
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "applyWallpaper" -> applyWallpaper(call, result)
            else -> result.notImplemented()
        }
    }

    private fun applyWallpaper(call: MethodCall, result: MethodChannel.Result) {
        val sourceAsset = call.argument<String>("sourceAsset")
        val type = call.argument<String>("type")

        if (sourceAsset.isNullOrEmpty() || type.isNullOrEmpty()) {
            result.error("INVALID_ARGUMENTS", "Source asset or wallpaper type was missing", null)
            return
        }

        preferencesHelper.saveSelectedWallpaper(sourceAsset, type)

        val serviceClass = when (type) {
            "video" -> VideoLiveWallpaperService::class.java
            "motion" -> ParallaxLiveWallpaperService::class.java
            else -> ParallaxLiveWallpaperService::class.java
        }

        val intent = Intent(WallpaperManager.ACTION_CHANGE_LIVE_WALLPAPER).apply {
            putExtra(WallpaperManager.EXTRA_LIVE_WALLPAPER_COMPONENT, ComponentName(applicationContext, serviceClass))
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }

        try {
            applicationContext.startActivity(intent)
            result.success(null)
        } catch (error: Exception) {
            result.error("WALLPAPER_FLOW_ERROR", error.localizedMessage, null)
        }
    }
}
