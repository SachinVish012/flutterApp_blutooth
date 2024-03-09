import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/randomgDogImg_provier.dart';


class RandomDogImage extends StatefulWidget {
  const RandomDogImage({super.key});

  @override
  State<RandomDogImage> createState() => _RandomDogImageState();
}

class _RandomDogImageState extends State<RandomDogImage> {

  @override
  void initState(){
    getImageInit();
    super.initState();
  }
  Future<void> getImageInit() async {
    await Provider.of<RandomDogIMGProvider>(context, listen: false).getImage();
  }
  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<RandomDogIMGProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Random Dog Image",style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<RandomDogIMGProvider>(
                  builder:(context, value, child) {
                    return Visibility(
                      visible: value.dogImage==""?false:true,
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Image.network(value.dogImage),
                      ),
                    );
                  },
              ),
          
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: (){
                  provider.getImage();
                },
                child: Text("Refresh",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
