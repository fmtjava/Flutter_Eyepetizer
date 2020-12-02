package com.flutter.eyepetizer.speech.plugin;

import androidx.annotation.Nullable;

import io.flutter.plugin.common.MethodChannel;

/**
 * 采用装饰者模式优化回掉方法
 */
public class ResultStateful implements MethodChannel.Result {

    private MethodChannel.Result result;
    private boolean called;//防止语音识别回调多次(由于MethodChannel的通讯是一次性的，即调用和回调是一次性的)

    public static ResultStateful of(MethodChannel.Result result) {
        return new ResultStateful(result);
    }

    private ResultStateful(MethodChannel.Result result) {
        this.result = result;
    }

    @Override
    public void success(@Nullable Object o) {
        if (called) {
            return;
        }
        called = true;
        result.success(o);
    }

    @Override
    public void error(String s, @Nullable String s1, @Nullable Object o) {
        if (called) {
            return;
        }
        called = true;
        result.error(s, s1, o);
    }

    @Override
    public void notImplemented() {
        if (called) {
            return;
        }
        called = true;
        result.notImplemented();
    }
}
