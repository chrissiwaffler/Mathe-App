package com.gymbei.mathe_app

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

import io.sentry.android.core.SentryAndroid
import io.sentry.SentryOptions.TracesSamplerCallback

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        SentryAndroid.init(this) { options ->
            options.dsn = "https://a2f38ac776c84defa34bb8a2ab9d9286@o942504.ingest.sentry.io/5891362"
            // To set a uniform sample rate
            options.tracesSampleRate = 1.0
        }
    }
}
