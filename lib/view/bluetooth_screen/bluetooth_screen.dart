import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_blutooth/res/custom_widget/custom_button.dart';

class BluetoothControl extends StatefulWidget {
  @override
  _BluetoothControlState createState() => _BluetoothControlState();
}

class _BluetoothControlState extends State<BluetoothControl> {
  final MethodChannel _channel = MethodChannel('com.test.test_blutooth/bluetooth');
  bool _bluetoothEnabled = false;
  bool _permissionGranted = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
    _checkBluetoothStatus();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Bluetooth Control",style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _bluetoothEnabled ? 'Bluetooth Enabled' : 'Bluetooth Disabled',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            CustomElevatedButton(
                onPress: _enableBluetooth,
                text: 'Enable Bluetooth'
            )
          ],
        ),
      ),
    );
  }
  Future<void> _checkPermission() async {
    // Check if permission is already granted
    bool? permission = await _channel.invokeMethod<bool>('checkPermission');
    setState(() {
      _permissionGranted = permission ?? false;
    });
  }

  Future<void> _checkBluetoothStatus() async {
    // Check Bluetooth status
    bool? bluetoothStatus = await _channel.invokeMethod<bool>('checkBluetooth');
    setState(() {
      _bluetoothEnabled = bluetoothStatus ?? false;
    });
  }

  Future<void> _enableBluetooth() async {
    if (!_permissionGranted) {
      // Request permission if not granted
      bool permissionGranted = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Permission Required"),
            content: Text("Please grant permission to enable Bluetooth."),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("OK"),
              ),
            ],
          );
        },
      );

      if (permissionGranted == null || !permissionGranted) {
        return;
      }

      bool? permission = await _channel.invokeMethod<bool>('requestPermission');
      setState(() {
        _permissionGranted = permission ?? false;
      });
    }

    if (_permissionGranted) {
      // Enable Bluetooth if permission granted
      await _channel.invokeMethod('enableBluetooth');
      _checkBluetoothStatus();
    }
  }
}
