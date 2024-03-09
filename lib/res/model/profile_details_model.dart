class UserModel {
  final String gender;
  final String title;
  final String firstName;
  final String lastName;
  final String streetName;
   var streetNumber;
  final String city;
  final String state;
  final String country;
  final String email;
  final String dob;
  final String registeredDate;
  final String picture;

  UserModel({
    required this.gender,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.streetName,
    required this.streetNumber,
    required this.city,
    required this.state,
    required this.country,
    required this.email,
    required this.dob,
    required this.registeredDate,
    required this.picture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      gender: json['gender'],
      title: json['name']['title'],
      firstName: json['name']['first'],
      lastName: json['name']['last'],
      streetName: json['location']['street']['name'],
      streetNumber: json['location']['street']['number'],
      city: json['location']['city'],
      state: json['location']['state'],
      country: json['location']['country'],
      email: json['email'],
      dob: json['dob']['date'],
      registeredDate: json['registered']['date'],
      picture: json['picture']['large'],
    );
  }
}