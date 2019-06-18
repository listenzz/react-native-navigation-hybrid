package com.navigationhybrid;

import android.content.Context;
import android.graphics.Color;
import android.graphics.Shader;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;

import me.listenzz.navigation.DrawableUtils;

public class Utils {

    private static final String TAG = "Navigation";

    public static Drawable createTabBarShadow(Context context, Bundle shadowImage) {
        Bundle image = shadowImage.getBundle("image");
        String color = shadowImage.getString("color");
        Drawable drawable = new ColorDrawable();
        if (image != null) {
            String uri = image.getString("uri");
            if (uri != null) {
                drawable = DrawableUtils.fromUri(context, uri);
                if (drawable instanceof BitmapDrawable) {
                    BitmapDrawable bitmapDrawable = (BitmapDrawable) drawable;
                    bitmapDrawable.setTileModeX(Shader.TileMode.REPEAT);
                }
            }
        } else if (color != null) {
            drawable = new ColorDrawable(Color.parseColor(color));
        }
        return drawable;
    }

    public static String getIconUri(Context context, String uri) {
        String iconUri = uri;
        if (uri != null && uri.startsWith("font://")) {
            iconUri = DrawableUtils.filepathFromFont(context, uri);
        }
        return  iconUri;
    }

    @NonNull
    static Bundle mergeOptions(@NonNull Bundle options, @NonNull String key, @NonNull ReadableMap readableMap) {
        Bundle bundle = options.getBundle(key);
        if (bundle == null) {
            bundle = new Bundle();
        }
        WritableMap writableMap = Arguments.createMap();
        writableMap.merge(Arguments.fromBundle(bundle));
        writableMap.merge(readableMap);
        Bundle result = Arguments.toBundle(writableMap);
        if (result == null) {
            throw new NullPointerException("merge fail.");
        }
        return result;
    }

    @NonNull
    static Bundle mergeOptions(@NonNull Bundle options, @Nullable ReadableMap readableMap) {
        if (readableMap == null) {
            return options;
        }
        WritableMap writableMap = Arguments.createMap();
        writableMap.merge(Arguments.fromBundle(options));
        writableMap.merge(readableMap);
        Bundle result = Arguments.toBundle(writableMap);
        if (result == null) {
            throw new NullPointerException("merge fail.");
        }
        return result;
    }
}
