package org.godotengine.godot.plugin.applauncher;

import org.godotengine.godot.Godot;
import org.godotengine.godot.plugin.GodotPlugin;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import android.content.Intent;
import android.content.Context;

import java.util.Arrays;
import java.util.List;

public class AppLauncher extends GodotPlugin {

    public static final String TAG = "AppLauncher";

    public AppLauncher(Godot godot) {
        super(godot);
    }
    @NonNull
    @Override
    public String getPluginName() {
        return "AppLauncher";
    }
    @NonNull
    @Override
    public List<String> getPluginMethods() {
        return Arrays.asList("launchapp");
    }

    private static void launchapp(String address, final Context context) {
        Intent launchIntent = context.getPackageManager().getLaunchIntentForPackage(address);
        if (launchIntent != null) {
            context.startActivity(launchIntent);
        }
    }
}
