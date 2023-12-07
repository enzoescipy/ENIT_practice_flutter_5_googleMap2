import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:enitproject/app/screen/Login/controller/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              centerTitle: true,
              title: const Text(
                '로그인',
                style: TextStyle(color: Colors.black),
              ),
              // leading: Padding(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 10.0,
              //   ),
              //   child: IconButton(
              //     icon: const Icon(Icons.arrow_back_ios),
              //     color: Colors.black,
              //     iconSize: 35.0,
              //     onPressed: () {
              //       Get.back();
              //     },
              //   ),
              // ),
            ),
            body: Center(
              child: Container(
                child: SizedBox(
                  width: 300,
                  child: ListView(
                    children: [
                      // TODO : implement the showable widget list.
                      // for example, like the CreateStory view.
                      ListViewIdField(),
                      ListViewPwField(),
                      ListViewLoginButton(),
                      ListViewAccountCreateButton(),
                      ListViewGoogleLoginButton(),
                    ],
                  ),
                ),
              ),
            )));
  }

  Widget ListViewIdField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 80,
            child: Text(
              "ID",
              textAlign: TextAlign.center,
            )),
        Expanded(
            child: TextField(
                controller: controller.idTextControl
                ))
      ],
    );
  }

  Widget ListViewPwField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 80,
            child: Text(
              "PW",
              textAlign: TextAlign.center,
            )),
        Expanded(
            child: TextField(
                controller: controller.pwTextControl
                ))
      ],
    );
  }

  Widget ListViewLoginButton() {
    return Padding(
      padding: EdgeInsets.only(left: 75, right: 75, top: 15, bottom: 5),
      child: OutlinedButton(
        child: const Text("로그인"),
        onPressed: controller.FireAuthLogin,
      ),
    );
  }

  Widget ListViewAccountCreateButton() {
    return Padding(
      padding: EdgeInsets.only(left: 75, right: 75, top: 5, bottom: 5),
      child: ElevatedButton(
        child: const Text("회원 가입"),
        onPressed: () {},
      ),
    );
  }

  Widget ListViewGoogleLoginButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("assets/google_favicon.png"),
                height: 35.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
