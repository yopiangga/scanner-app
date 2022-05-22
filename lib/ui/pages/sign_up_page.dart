part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 22),
                height: 56,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                    ),
                    Center(
                      child: Text(
                        "Create New\nAccount",
                        style: blackTextFont.copyWith(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 104,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                            image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                              fit: BoxFit.contain,
                            ),
                          )),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () async {
                          // if (widget.registrationData.profileImage == null) {
                          //   widget.registrationData.profileImage =
                          //       await getImage();
                          // } else {
                          //   widget.registrationData.profileImage = null;
                          // }
                          // setState(() {});
                        },
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // image: DecorationImage(
                            //     image: AssetImage(
                            //         (widget.registrationData.profileImage ==
                            //                 null)
                            //             ? "assets/btn_add_photo.png"
                            //             : "assets/btn_del_photo.png"))
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 36,
              ),
              // TextField(
              //   controller: nameController,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10)),
              //     labelText: "Full name",
              //     hintText: "Full name",
              //   ),
              // ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Email address",
                  hintText: "Email address",
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Password",
                  hintText: "Password",
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: retypePasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Confirm password",
                  hintText: "Confirm password",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FloatingActionButton(
                onPressed: () async {
                  if (!(emailController.text.trim() != "" &&
                      passwordController.text.trim() != "" &&
                      retypePasswordController.text.trim() != "")) {
                    Flushbar(
                      duration: Duration(milliseconds: 4000),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: Color(0xFFFF5C83),
                      message: "Please fill all the fields",
                    )..show(context);
                  } else if (passwordController.text.trim() !=
                      retypePasswordController.text.trim()) {
                    Flushbar(
                      duration: Duration(milliseconds: 4000),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: Color(0xFFFF5C83),
                      message: "Password doesn't match",
                    )..show(context);
                  } else if (passwordController.text.length < 6) {
                    Flushbar(
                      duration: Duration(milliseconds: 4000),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: Color(0xFFFF5C83),
                      message: "Password's length min 6 characters",
                    )..show(context);
                  } else if (!EmailValidator.validate(emailController.text)) {
                    Flushbar(
                      duration: Duration(milliseconds: 4000),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: Color(0xFFFF5C83),
                      message: "Wrong formatted email address",
                    )..show(context);
                  } else {
                    // String name = nameController.text.trim();
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();
                    final result = await AuthServices.signUp(email, password);

                    if (result?.uid == null)
                      FlushbarWidget(context, result.message);
                    else
                      Navigator.pop(context);
                  }
                  // print("Signup");
                  // await AuthServices.signUp("yopiangga@gmail.com", "123456");
                  // print("Signup done");
                },
                child: Icon(Icons.arrow_forward),
                elevation: 0,
                backgroundColor: mainColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
