package com.test.test_blutooth;

import android.Manifest;
import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.test.test_blutooth/bluetooth";
    private static final int REQUEST_ENABLE_BT = 1;
    private static final int REQUEST_PERMISSION_BT = 2;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("checkPermission")) {
                                checkPermission(result);
                            } else if (call.method.equals("requestPermission")) {
                                requestPermission(result);
                            } else if (call.method.equals("checkBluetooth")) {
                                checkBluetooth(result);
                            } else if (call.method.equals("enableBluetooth")) {
                                enableBluetooth(result);
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    private void checkPermission(MethodChannel.Result result) {
        Context context = getContext();
        if (context != null) {
            int permissionStatus = ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH);
            result.success(permissionStatus == PackageManager.PERMISSION_GRANTED);
        } else {
            result.success(false);
        }
    }

    private void requestPermission(MethodChannel.Result result) {
        ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.BLUETOOTH}, REQUEST_PERMISSION_BT);
        // We'll handle the result in onRequestPermissionsResult
        result.success(null);
    }

    private void checkBluetooth(MethodChannel.Result result) {
        BluetoothAdapter bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        if (bluetoothAdapter != null) {
            result.success(bluetoothAdapter.isEnabled());
        } else {
            result.success(false);
        }
    }

    private void enableBluetooth(MethodChannel.Result result) {
        BluetoothAdapter bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        if (bluetoothAdapter != null) {
            if (!bluetoothAdapter.isEnabled()) {
                Intent enableBtIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
                startActivityForResult(enableBtIntent, REQUEST_ENABLE_BT);
            } else {
                result.success(null); // Bluetooth is already enabled
            }
        } else {
            result.error("UNAVAILABLE", "Bluetooth is not available on this device", null);
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == REQUEST_PERMISSION_BT) {
            // Check if permission is granted
            boolean permissionGranted = grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED;
            MethodChannel channel = new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL);
            channel.invokeMethod("requestPermissionResult", permissionGranted);
        }
    }
}
