package com.flutter.flutter_eyepetizer;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Bundle;
import android.provider.Settings;

import com.flutter.eyepetizer.speech.plugin.SpeechPlugin;
import com.flutter.eyepetizer.speech.plugin.SpeechManager;

import org.devio.flutter.splashscreen.SplashScreen;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    SpeechPlugin mSpeechPlugin;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        SplashScreen.show(this, true);
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        SpeechManager.getInstance().init(this);
        mSpeechPlugin = SpeechPlugin.registerWith(registrarFor("com.flutter.eyepetizer.speech.plugin.SpeechPlugin"));
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == SpeechPlugin.RECOGNIZER_REQUEST_CODE) {
            if (grantResults.length > 0) {
                int grantedSize = 0;
                for (int grantResult : grantResults) {
                    if (grantResult == PackageManager.PERMISSION_GRANTED) {
                        grantedSize++;
                    }
                }
                if (grantedSize == grantResults.length) {
                    mSpeechPlugin.startRecognizer();
                } else {
                    showWaringDialog();
                }
            } else {
                showWaringDialog();
            }
        }
    }

    private void showWaringDialog() {
        new AlertDialog.Builder(this,android.R.style.Theme_Material_Light_Dialog_Alert)
                .setTitle(R.string.waring)
                .setMessage(R.string.permission_waring)
                .setPositiveButton(R.string.sure, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        go2AppSettings();
                    }
                }).setNegativeButton(R.string.cancel, null).show();
    }

    private void go2AppSettings() {
        Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
        Uri uri = Uri.fromParts("package", getPackageName(), null);
        intent.setData(uri);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(intent);
    }
}
