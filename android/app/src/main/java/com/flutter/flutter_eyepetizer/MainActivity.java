package com.flutter.flutter_eyepetizer;

import android.os.Bundle;

import com.flutter.eyepetizer.speech.plugin.SpeechPlugin;
import com.flutter.eyepetizer.speech.plugin.SpeechManager;

import org.devio.flutter.splashscreen.SplashScreen;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        SplashScreen.show(this, true);
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        SpeechManager.getInstance().init(this);
        SpeechPlugin.registerWith(registrarFor("com.flutter.eyepetizer.speech.plugin.SpeechPlugin"));
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);

    }
}
