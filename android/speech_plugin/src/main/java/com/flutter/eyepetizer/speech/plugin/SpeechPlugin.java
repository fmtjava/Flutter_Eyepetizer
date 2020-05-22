package com.flutter.eyepetizer.speech.plugin;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Build;

import androidx.core.app.ActivityCompat;

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class SpeechPlugin implements MethodChannel.MethodCallHandler {

    public static final int RECOGNIZER_REQUEST_CODE = 0x0010;
    private Activity activity;
    private ResultStateful resultStateful;

    public static SpeechPlugin registerWith(PluginRegistry.Registrar registrar) {
        MethodChannel methodChannel = new MethodChannel(registrar.messenger(), "speech_plugin");
        SpeechPlugin speechPlugin = new SpeechPlugin(registrar);
        methodChannel.setMethodCallHandler(speechPlugin);
        return speechPlugin;
    }

    private SpeechPlugin(PluginRegistry.Registrar registrar) {
        activity = registrar.activity();
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        switch (call.method) {
            case "start":
                resultStateful = ResultStateful.of(result);
                startRecognizer();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    public void startRecognizer() {
        List<String> checkResultList = checkPermissions();
        if (checkResultList.size() > 0) {
            ActivityCompat.requestPermissions(activity, checkResultList.toArray(new String[0]), RECOGNIZER_REQUEST_CODE);
        } else {
            SpeechManager.getInstance().recognize(recognizerResultListener);
        }
    }

    private List<String> checkPermissions() {
        List<String> checkResultList = new ArrayList<>();

        if (Build.VERSION.SDK_INT >= 23) {
            String[] permissions = new String[]
                    {Manifest.permission.WRITE_EXTERNAL_STORAGE,
                            Manifest.permission.READ_PHONE_STATE,
                            Manifest.permission.READ_EXTERNAL_STORAGE,
                            Manifest.permission.RECORD_AUDIO, Manifest.permission.READ_CONTACTS,
                            Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.ACCESS_FINE_LOCATION};

            for (String permission : permissions) {
                if (ActivityCompat.checkSelfPermission(activity,
                        permission) != PackageManager.PERMISSION_GRANTED) {
                    checkResultList.add(permission);
                }
            }
        }

        return checkResultList;
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
