import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_blutooth/view/first_screen/random_dog_image.dart';
import 'package:test_blutooth/view/profile_screen/profile_view.dart';

import '../res/custom_widget/custom_button.dart';
import 'bluetooth_screen/bluetooth_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(child: Text("Home",style: TextStyle(color: Colors.white),)),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //------for random dog image
            CustomElevatedButton(
              onPress: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RandomDogImage()));
              },
              text:  'Random Dog Image',
            ),

            //-----for user details
            CustomElevatedButton(
              onPress: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileView()));
              },
              text:  'Profile Details',
            ),

            //----for Bluetooth
            CustomElevatedButton(
              onPress: (){
                print("clicked on Bluetooth----1");
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BluetoothControl()));
                //enableBluetooth();
              },
              text:  'Enable Bluetooth',
            ),
          ],
        ),
      ),
    );
  }
  // Method to enable Bluetooth via platform channel
  Future<void> enableBluetooth() async {
    print("clicked on Bluetooth----2");
    const platform = MethodChannel('com.test.test_blutooth/bluetooth');
    try {
      await platform.invokeMethod('enableBluetooth');
    } on PlatformException catch (e) {
      print("Failed to enable Bluetooth: '${e.message}'.");
    }
  }
}
