package com.aurawallpapers.app.service

import android.media.MediaPlayer
import android.service.wallpaper.WallpaperService
import android.view.SurfaceHolder
import com.aurawallpapers.app.helper.WallpaperPreferencesHelper

class VideoLiveWallpaperService : WallpaperService() {

    override fun onCreateEngine(): Engine {
        return VideoEngine()
    }

    inner class VideoEngine : Engine(), SurfaceHolder.Callback {
        private var mediaPlayer: MediaPlayer? = null
        private val preferencesHelper = WallpaperPreferencesHelper(applicationContext)

        override fun onCreate(surfaceHolder: SurfaceHolder) {
            super.onCreate(surfaceHolder)
            surfaceHolder.addCallback(this)
        }

        override fun onSurfaceCreated(holder: SurfaceHolder) {
            super.onSurfaceCreated(holder)
            prepareVideo(holder)
        }

        override fun onSurfaceDestroyed(holder: SurfaceHolder) {
            super.onSurfaceDestroyed(holder)
            pauseVideo()
        }

        override fun onVisibilityChanged(visible: Boolean) {
            super.onVisibilityChanged(visible)
            if (visible) {
                resumeVideo()
            } else {
                pauseVideo()
            }
        }

        private fun prepareVideo(holder: SurfaceHolder) {
            val sourceAsset = preferencesHelper.getSelectedWallpaperSource() ?: return
            releaseVideo()

            try {
                val assetFileDescriptor = assets.openFd("flutter_assets/$sourceAsset")
                val player = MediaPlayer().apply {
                    setDataSource(assetFileDescriptor.fileDescriptor, assetFileDescriptor.startOffset, assetFileDescriptor.length)
                    setSurface(holder.surface)
                    isLooping = true
                    setVolume(0f, 0f)
                    prepare()
                    start()
                }
                mediaPlayer = player
            } catch (exception: Exception) {
                exception.printStackTrace()
            }
        }

        private fun pauseVideo() {
            mediaPlayer?.takeIf { it.isPlaying }?.pause()
        }

        private fun resumeVideo() {
            mediaPlayer?.takeIf { !it.isPlaying }?.start()
        }

        private fun releaseVideo() {
            mediaPlayer?.release()
            mediaPlayer = null
        }
    }
}
