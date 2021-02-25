import 'package:flutter/material.dart';
import 'package:login_form/model/account-model.dart';

class EditProfile extends StatefulWidget {
  final Account account;
  EditProfile({this.account});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController fNameController;
  TextEditingController lNameController;
  TextEditingController phoneController;
  @override
  void initState() {
    var lName = widget.account.lastName;
    var fName = widget.account.firstName;
    var phone = widget.account.phone;

    fNameController=TextEditingController(text: fName);
    lNameController = TextEditingController(text: lName);
    phoneController = TextEditingController(text: phone);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editer le profil'),),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: lNameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintStyle: TextStyle(color: Colors.teal.shade900),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: fNameController,
                decoration: InputDecoration(
                  labelText: 'Surname',
                  hintStyle: TextStyle(color: Colors.teal.shade900),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Telephone',
                  hintStyle: TextStyle(color: Colors.teal.shade900),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: double.maxFinite,
                child: RaisedButton(onPressed: (){},
                child: Text('Validate', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),),
                color: Colors.blue,),
              ),
            )

          ],
        ),
      ),
    );
  }
}
