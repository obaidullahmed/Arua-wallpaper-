package com.aurawallpapers.app.service

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Canvas
import android.graphics.Paint
import android.graphics.RectF
import android.service.wallpaper.WallpaperService
import android.view.SurfaceHolder
import android.os.Handler
import android.os.Looper
import com.aurawallpapers.app.helper.SensorHelper
import com.aurawallpapers.app.helper.WallpaperPreferencesHelper

class ParallaxLiveWallpaperService : WallpaperService() {

    override fun onCreateEngine(): Engine {
        return ParallaxEngine()
    }

    inner class ParallaxEngine : Engine(), SurfaceHolder.Callback {
        private val preferencesHelper = WallpaperPreferencesHelper(applicationContext)
        private val handler = Handler(Looper.getMainLooper())
        private val paint = Paint(Paint.ANTI_ALIAS_FLAG)
        private var bitmap: Bitmap? = null
        private var offsetX = 0f
        private var offsetY = 0f
        private var drawTask: Runnable? = null
        private val sensorHelper = SensorHelper(applicationContext) { x, y ->
            offsetX = x
            offsetY = y
            drawFrame()
        }

        override fun onCreate(surfaceHolder: SurfaceHolder) {
            super.onCreate(surfaceHolder)
            surfaceHolder.addCallback(this)
        }

        override fun onSurfaceCreated(holder: SurfaceHolder) {
            super.onSurfaceCreated(holder)
            loadWallpaperImage()
            drawFrame()
        }

        override fun onSurfaceDestroyed(holder: SurfaceHolder) {
            super.onSurfaceDestroyed(holder)
            sensorHelper.stop()
            handler.removeCallbacksAndMessages(null)
        }

        override fun onVisibilityChanged(visible: Boolean) {
            super.onVisibilityChanged(visible)
            if (visible) {
                sensorHelper.start()
                scheduleFrameUpdate()
            } else {
                sensorHelper.stop()
                handler.removeCallbacksAndMessages(null)
            }
        }

        private fun loadWallpaperImage() {
            val sourceAsset = preferencesHelper.getSelectedWallpaperSource() ?: return
            try {
                assets.open("flutter_assets/$sourceAsset").use { inputStream ->
                    bitmap = BitmapFactory.decodeStream(inputStream)
                }
            } catch (exception: Exception) {
                exception.printStackTrace()
            }
        }

        private fun scheduleFrameUpdate() {
            val delay = if (preferencesHelper.isBatterySaverEnabled()) 1000L else 40L
            drawTask = Runnable {
                drawFrame()
                handler.postDelayed(drawTask!!, delay)
            }
            handler.post(drawTask!!)
        }

        private fun drawFrame() {
            val holder = surfaceHolder ?: return
            val image = bitmap ?: return
            val canvas: Canvas = holder.lockCanvas() ?: return
            try {
                canvas.drawColor(0xFF000000.toInt())
                val width = canvas.width.toFloat()
                val height = canvas.height.toFloat()
                val scale = max(width / image.width, height / image.height)
                val drawWidth = image.width * scale
                val drawHeight = image.height * scale
                val horizontalOffset = (width - drawWidth) / 2 + (offsetX * 40)
                val verticalOffset = (height - drawHeight) / 2 + (offsetY * 40)
                val targetRect = RectF(horizontalOffset, verticalOffset, horizontalOffset + drawWidth, verticalOffset + drawHeight)
                canvas.drawBitmap(image, null, targetRect, paint)
            } finally {
                holder.unlockCanvasAndPost(canvas)
            }
        }
    }
}
