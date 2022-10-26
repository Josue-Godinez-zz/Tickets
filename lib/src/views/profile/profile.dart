import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../widgets/customeditabletext.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Profile();
}

class _Profile extends State<Profile> {
  final ImagePicker _imagePicker = ImagePicker();
  // final storage = FirebaseStorage.instanceFor(
  //         bucket: 'gs://flutter-proyect-movil.appspot.com/')
  //     .ref();

  // UploadTask? uploadFile(String destination, File file) {
  //   try {
  //     final ref = FirebaseStorage.instance.ref(destination);
  //     return ref.putFile(file);
  //   } on FirebaseException {
  //     return null;
  //   }
  // }

  Future openCamara() async {
    // UploadTask? task;
    await Permission.camera.request();
    if (await Permission.camera.request().isGranted) {
      XFile? photo = await _imagePicker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        try {
          // task = uploadFile(
          //     'avatar/${LoginController.gmailLogin ? LoginController.getUser()!.displayName!.trim() : LoginController.getUserDto()!.name!.trim()}',
          // File(photo.path));
          // if (task == null) return;
          // SmartDialog.showLoading();
          // final snapshot = await task.whenComplete(() {});
          // final urlPath = await snapshot.ref.getDownloadURL();
          // widget.changeAvatar(urlPath);
          SmartDialog.dismiss();
          setState(() {});
        } catch (error) {
          SmartDialog.dismiss();
        }
      }
      SmartDialog.dismiss();
    } else {
      Permission.camera.request();
    }
  }

  Future openGalery() async {
    // UploadTask? task;
    if (await Permission.storage.request().isGranted) {
      XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        try {
          // task = uploadFile(
          //     'avatar/${LoginController.gmailLogin ? LoginController.getUser()!.displayName!.trim() : LoginController.getUserDto()!.name!.trim()}',
          //     File(image.path));
          // if (task == null) return;
          // SmartDialog.showLoading();
          // final snapshot = await task.whenComplete(() {});
          // final urlPath = await snapshot.ref.getDownloadURL();
          // widget.changeAvatar(urlPath);
          SmartDialog.dismiss();
          setState(() {});
        } catch (error) {
          SmartDialog.dismiss();
        }
      }
      SmartDialog.dismiss();
    } else {
      Permission.storage.request();
    }
  }

  @override
  Widget build(Object context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Column(
            children: [
              Badge(
                  showBadge: true,
                  badgeColor: const Color.fromARGB(144, 133, 43, 236),
                  badgeContent: const Icon(Icons.add_a_photo),
                  child: GestureDetector(
                    onTap: () {
                      SmartDialog.show(
                          alignment: Alignment.centerRight,
                          animationType: SmartAnimationType.fade,
                          builder: (BuildContext context) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  child: Row(children: const [
                                    Icon(Icons.camera_alt_outlined),
                                    Text('Camara')
                                  ]),
                                  onPressed: () => {openCamara()},
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                ElevatedButton(
                                  child: Row(children: const [
                                    Icon(Icons.photo),
                                    Text('Galery')
                                  ]),
                                  onPressed: () => {openGalery()},
                                )
                              ],
                            );
                          });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(360),
                      child: const ProfilePicture(
                        fontsize: 21,
                        random: true,
                        name: 'USERNAME',
                        radius: 45,
                      ),
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 35),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Name",
              style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold)),
        ),
        CustomEditableText(
          data: "USERNAME",
          field: 'name',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 30),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Username ",
              style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold)),
        ),
        CustomEditableText(
          data: "USERNAME",
          field: 'username',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 30),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Phone",
              style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold)),
        ),
        CustomEditableText(
          data: "DATA",
          field: 'phone',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 30),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Email",
              style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold)),
        ),
        CustomEditableText(
          data: "DATA",
          field: 'email',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
