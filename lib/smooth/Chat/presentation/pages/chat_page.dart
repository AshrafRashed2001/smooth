import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth/core/Firebase/fire_base_helper.dart';
import 'package:smooth/core/SharedPref/shared_helper.dart';
import 'package:smooth/core/Widgets/pop_widget.dart';
import 'package:smooth/core/Widgets/text_fieldes.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/core/resources/extentions.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController controller = TextEditingController();
  DatabaseReference meAsUser = FirebaseDatabase.instance
      .ref('users/${SharedHelper.getstring(key: 'UID')}/messages');
  void sendMessage({required bool isPhoto, required String photo}) async {
    final Map data = {
      'text': !isPhoto ? controller.text : photo,
      'name': SharedHelper.getstring(key: 'NAME'),
      'email': SharedHelper.getstring(key: 'EMAIL'),
      'time': DateTime.now().toString(),
      'picture': SharedHelper.getstring(key: 'PICTURE'),
      'isPhoto': isPhoto
    };

    DatabaseReference meAsUser = FirebaseDatabase.instance
        .ref('users/${SharedHelper.getstring(key: 'UID')}/messages')
        .push();
    DatabaseReference adminUser = FirebaseDatabase.instance
        .ref(
            'users/0xEK6DKCogUlKr1w1HI9Iu9LgsJ3/chats/${SharedHelper.getstring(key: 'UID')}')
        .push();
    await meAsUser.set(data);
    await adminUser.set(data);
    controller.clear();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const PopWidget(),
        leadingWidth: 70.w,
      ),
      body: Stack(children: [
        Column(
          children: [
            Image.asset(
                'assets/images/Black Red Minimalist Speed Car Logo (5) 4.png'),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('assets/images/2back.png'),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/images/1back.png'),
          ],
        ),
        Container(
          height: context.height,
          width: context.width,
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
        ),
        Column(
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                query: meAsUser.orderByChild('time'),
                itemBuilder: (context, snapshot, animation, index) {
                  return Padding(
                    padding: EdgeInsets.all(9.h),
                    child: Row(
                      mainAxisAlignment:
                          snapshot.child('email').value.toString() ==
                                  SharedHelper.getstring(key: 'EMAIL')
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: snapshot.child('email').value.toString() !=
                              SharedHelper.getstring(key: 'EMAIL'),
                          child: Row(
                            children: [
                              snapshot.child('picture').value.toString() != ''
                                  ? CircleAvatar(
                                      radius: 18.h,
                                      backgroundImage: NetworkImage(snapshot
                                          .child('picture')
                                          .value
                                          .toString()),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: AppColors.bottomColor,
                                      radius: 18.h,
                                      child: Center(
                                          child: Image.asset(
                                        'assets/images/Black Red Minimalist Speed Car Logo (5) 3.png',
                                        height: 25.h,
                                      )),
                                    ),
                              3.widthBox,
                            ],
                          ),
                        ),
                        bool.parse(snapshot
                                    .child('isPhoto')
                                    .value
                                    .toString()) !=
                                true
                            ? Container(
                                width: 150.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.h),
                                    color: snapshot
                                                .child('email')
                                                .value
                                                .toString() ==
                                            SharedHelper.getstring(key: 'EMAIL')
                                        ? AppColors.primaryColor
                                        : AppColors.bottomColor),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.h),
                                    child: Text(
                                      snapshot.child('text').value.toString(),
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: snapshot
                                                      .child('email')
                                                      .value
                                                      .toString() ==
                                                  SharedHelper.getstring(
                                                      key: 'EMAIL')
                                              ? AppColors.bottomColor
                                              : Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: 200.h,
                                width: 200.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.h),
                                    color: AppColors.primaryColor),
                                child: Padding(
                                  padding: EdgeInsets.all(8.h),
                                  child: Image.network(
                                    snapshot.child('text').value.toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                        Visibility(
                          visible: snapshot.child('email').value.toString() ==
                              SharedHelper.getstring(key: 'EMAIL'),
                          child: Row(
                            children: [
                              3.widthBox,
                              snapshot.child('picture').value.toString() != ''
                                  ? CircleAvatar(
                                      radius: 18.h,
                                      backgroundImage: NetworkImage(snapshot
                                          .child('picture')
                                          .value
                                          .toString()),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: AppColors.bottomColor,
                                      radius: 18.h,
                                      child: Center(
                                        child: Icon(
                                          Icons.person,
                                          size: 18.h,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            FieldGeneralWidget(
              controller: controller,
              isSecret: false,
              iconPre: InkWell(
                onTap: () async {
                  await ImagePicker()
                      .pickImage(source: ImageSource.gallery)
                      .then((value) {
                    if (value != null) {
                      FirebaseHelper.uploadImage(file: File(value.path))
                          .then((value) {
                        sendMessage(isPhoto: true, photo: value);
                      });
                    } else {}
                  });
                },
                child: Icon(
                  Icons.photo,
                  size: 20.h,
                  color: AppColors.bottomColor,
                ),
              ),
              suffIcon: InkWell(
                onTap: () {
                  if (controller.text.trim().isNotEmpty) {
                    sendMessage(isPhoto: false, photo: '');
                  } else {}
                },
                child: Icon(
                  Icons.send,
                  size: 20.h,
                  color: AppColors.bottomColor,
                ),
              ),
              ispass: false,
              name: 'type message..',
              val: (value) {},
            )
          ],
        ),
      ]),
    );
  }
}
