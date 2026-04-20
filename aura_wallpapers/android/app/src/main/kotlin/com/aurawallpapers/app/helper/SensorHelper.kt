package com.aurawallpapers.app.helper

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import kotlin.math.max

class SensorHelper(
    context: Context,
    private val onSensorUpdated: (Float, Float) -> Unit,
) : SensorEventListener {

    private val sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager
    private val accelerometer: Sensor? = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
    private val filterAlpha = 0.12f
    private val gravity = FloatArray(3)

    fun start() {
        accelerometer?.let {
            sensorManager.registerListener(this, it, SensorManager.SENSOR_DELAY_UI)
        }
    }

    fun stop() {
        sensorManager.unregisterListener(this)
    }

    override fun onSensorChanged(event: SensorEvent) {
        val rawX = event.values[0]
        val rawY = event.values[1]

        gravity[0] = filterAlpha * gravity[0] + (1 - filterAlpha) * rawX
        gravity[1] = filterAlpha * gravity[1] + (1 - filterAlpha) * rawY

        val x = (rawX - gravity[0]) / SensorManager.GRAVITY_EARTH
        val y = (rawY - gravity[1]) / SensorManager.GRAVITY_EARTH
        val normalizedX = max(-1f, minOf(1f, x))
        val normalizedY = max(-1f, minOf(1f, y))

        onSensorUpdated(normalizedX, normalizedY)
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
        // no-op
    }
}
