package com.aurawallpapers.app

import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.aurawallpapers.app.channel.WallpaperMethodChannelHandler

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        WallpaperMethodChannelHandler(
            context = applicationContext,
            messenger = flutterEngine.dartExecutor.binaryMessenger,
        )
    }
}
