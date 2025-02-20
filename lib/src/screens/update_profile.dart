import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:profile_screen/src/utils/alert.dart';
import 'package:profile_screen/src/utils/validators.dart';
import 'package:profile_screen/src/widgets/label.dart';

import '../utils/export.dart';

import 'package:file_picker/file_picker.dart';

import 'package:profile_screen/src/services/service.dart';

//Profile Update page
class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController fullname = TextEditingController(text: "");
  TextEditingController phoneNumber = TextEditingController(text: "");
  TextEditingController email = TextEditingController(text: "");

  final key = GlobalKey<FormState>();

  //TODOPass token here by initializing an instance of the service
  final apiService = ApiService(token: "");
  String? base64file;
  File? filePicked;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: white,
        title: Text("Update Profile"),
        leading: IconButton.filled(
          style: IconButton.styleFrom(
            backgroundColor: backgroundColor,
          ),
          color: neutralStrong,
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.all(20.0),
              child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Profile Photo",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        //pick file
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'pdf', 'jpeg', 'png'],
                        );
                        //convert file to base64 is pick is successfull and setState
                        if (result != null) {
                          File file = File(result.files.single.path!);
                          List<int> fileBytes = await file.readAsBytes();
                          // Convert to Base64
                          setState(() {
                            filePicked = file;
                            base64file = base64Encode(fileBytes);
                          });
                        } else {
                          // ignore: use_build_context_synchronously
                          context.showSnackBar(
                              SnackBar(content: Text("No file picked")));
                        }
                      },
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        color: neutral,
                        radius: Radius.circular(12),
                        padding: EdgeInsets.all(6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            child: Center(
                              child: filePicked != null
                                  ? Column(
                                      children: [Text(filePicked!.path)],
                                    )
                                  : Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SvgPicture.asset("assets/svg/file.svg"),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Drag and drop or Select",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            "Supported formats: .png, .jpg, .jpeg, apple format.",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: neutral)),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Label(label: "Full name"),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: fullname,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Full name is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Label(label: "Phone Number"),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: phoneNumber,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.numberWithOptions(),
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Phone number is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Label(label: "Email"),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: email,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onChanged: (value) {},
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => EmailValidator().validate(value),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(color: white),
        child: TextButton(
          onPressed: () async {
            //Validates the form field
            if (key.currentState!.validate()) {
              try {
                setState(() {
                  loading = true;
                });

                //use base64FILE where required
                var data = {
                  "fullName": fullname.text,
                  "phone": phoneNumber.text,
                  "email": email.text
                };
                final response = await apiService.submitFormdata(data);

                ///Show snack bar on success

                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.data)));
              } catch (e) {
                setState(() {
                  loading = false;
                });
                // ignore: use_build_context_synchronously
                context.showSnackBar(SnackBar(
                    content: SnackBar(
                  content: Text(
                    e.toString(),
                  ),
                  backgroundColor: red,
                )));
              }
            }
          },
          style: TextButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: loading
              ? SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: white,
                  ))
              : Text(
                  "Save Changes",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: white),
                ),
        ),
      ),
    );
  }
}

// https://fixit-testing.tuulbox.app/api/accounts/6d475484-c5d6-492d-98c7-27b0733806b1/
