package com.flutter.eyepetizer.speech.plugin;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Build;
import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import java.util.ArrayList;
import java.util.List;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * Flutter1.12升级后的插件问题可参考以下文章：
 * 1.https://www.bookstack.cn/read/flutter-1.2-zh/eee5c807276f94db.md
 * 2.https://www.jianshu.com/p/579d94f4ddf5
 * 3.https://github.com/flutter/flutter/wiki/Upgrading-pre-1.12-Android-projects
 */
public class SpeechPlugin implements FlutterPlugin, ActivityAware, MethodChannel.MethodCallHandler {

    public static final int RECOGNIZER_REQUEST_CODE = 0x0010;
    private Activity mActivity;
    private ResultStateful mResultStateful;

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        switch (call.method) {
            case "start":
                mResultStateful = ResultStateful.of(result);
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
            ActivityCompat.requestPermissions(mActivity, checkResultList.toArray(new String[0]), RECOGNIZER_REQUEST_CODE);
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
                if (ActivityCompat.checkSelfPermission(mActivity,
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
            if (mResultStateful != null) {
                mResultStateful.success(result);
            }
        }

        @Override
        public void onError(String errorMsg) {
            if (mResultStateful != null) {
                mResultStateful.error(errorMsg, null, null);
            }
        }
    };

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        MethodChannel methodChannel = new MethodChannel(binding.getBinaryMessenger(), "speech_plugin");
        methodChannel.setMethodCallHandler(this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        mActivity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {

    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    }

    @Override
    public void onDetachedFromActivity() {

    }
}
