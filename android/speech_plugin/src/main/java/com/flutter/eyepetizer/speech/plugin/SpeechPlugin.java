package com.flutter.eyepetizer.speech.plugin;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Build;

import androidx.core.app.ActivityCompat;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class SpeechPlugin implements MethodChannel.MethodCallHandler {

    private Activity activity;
    private ResultStateful resultStateful;

    public static void registerWith(PluginRegistry.Registrar registrar) {
        MethodChannel methodChannel = new MethodChannel(registrar.messenger(), "speech_plugin");
        SpeechPlugin speechPlugin = new SpeechPlugin(registrar);
        methodChannel.setMethodCallHandler(speechPlugin);
    }

    private SpeechPlugin(PluginRegistry.Registrar registrar) {
        activity = registrar.activity();
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        switch (call.method) {
            case "requestPermissions":
                requestPermissions();
                break;
            case "start":
                requestPermissions();
                resultStateful = ResultStateful.of(result);
                SpeechManager.getInstance().recognize(recognizerResultListener);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void requestPermissions() {
        try {
            if (Build.VERSION.SDK_INT >= 23) {
                int permission = ActivityCompat.checkSelfPermission(activity,
                        Manifest.permission.WRITE_EXTERNAL_STORAGE);
                if (permission != PackageManager.PERMISSION_GRANTED) {
                    ActivityCompat.requestPermissions(activity, new String[]
                            {Manifest.permission.WRITE_EXTERNAL_STORAGE,
                                    Manifest.permission.LOCATION_HARDWARE, Manifest.permission.READ_PHONE_STATE,
                                    Manifest.permission.WRITE_SETTINGS, Manifest.permission.READ_EXTERNAL_STORAGE,
                                    Manifest.permission.RECORD_AUDIO, Manifest.permission.READ_CONTACTS,
                                    Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.ACCESS_FINE_LOCATION}, 0x0010);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private SpeechManager.RecognizerResultListener recognizerResultListener = new SpeechManager.RecognizerResultListener() {
        @Override
        public void onResult(String result) {
            if (resultStateful != null) {
                resultStateful.success(result);
            }
        }

        @Override
        public void onError(String errorMsg) {
            if (resultStateful != null) {
                resultStateful.error(errorMsg, null, null);
            }
        }
    };

}
