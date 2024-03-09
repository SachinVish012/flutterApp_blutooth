import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../res/custom_widget/custom_textformfield.dart';
import '../../res/model/profile_details_model.dart';

class UserDetails extends StatefulWidget {
  final UserModel user;

  UserDetails({required this.user});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController dobController=TextEditingController();
  TextEditingController registeredDateController=TextEditingController();
  TextEditingController locationController=TextEditingController();
  String profilePic="";

  @override
  void initState() {
    profilePic=widget.user.picture.toString();
    nameController.text="${widget.user.title} ${ widget.user.firstName} ${ widget.user.lastName}";
    emailController.text=widget.user.email.toString();
    //dobController.text=widget.user.dob.toString();
    locationController.text="${widget.user.streetNumber.toString()} ${widget.user.streetName.toString()}, ${widget.user.city}, ${widget.user.state}, ${widget.user.country}";
    setDate();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        margin: EdgeInsets.only(top: 20,left: 15,right: 15,bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Visibility(
                visible: profilePic==""?false:true,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blue,
                      width: 3.0,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: Image.network(
                      profilePic,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomTextFormField(
                controller: nameController,
                lebelText: "Name",
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                controller: emailController,
                lebelText: "Email",
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                controller: dobController,
                lebelText: "DOB",
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                controller: locationController,
                lebelText: "Location",
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                controller: registeredDateController,
                lebelText: "Number of days ",
              ),
            ],
          ),
        ),
      ),
    );
  }
  setDate(){
    var date=widget.user.dob.toString();
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat.yMMMMEEEEd().add_Hms().format(dateTime);
    String endDateString = DateTime.now().toIso8601String();

    //---calculate Number of days passed since registered
    String startDateString =widget.user.registeredDate.toString();
    DateTime startDate = DateTime.parse(startDateString);
    DateTime endDate = DateTime.parse(endDateString);
    Duration difference = endDate.difference(startDate);
    // Calculate the number of days
    int numberOfDays = difference.inDays;
    print(numberOfDays.toString()+"----days-----");
    setState(() {
      dobController.text=formattedDate;
      registeredDateController.text=numberOfDays.toString();
    });
  }
}