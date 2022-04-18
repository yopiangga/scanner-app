part of 'pages.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSignIn = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 70,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 70, bottom: 40),
                      child: Text("Welcome Back\nExplorer",
                          style: blackTextFont.copyWith(fontSize: 20)),
                    ),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          isEmailValid = EmailValidator.validate(text);
                        });
                      },
                      controller: _emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Email Address",
                          hintText: "Email Address"),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          isPasswordValid = text.length >= 6;
                        });
                      },
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Password",
                          hintText: "Password"),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Text("Forgot Password?",
                            style: greyTextFont.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w400)),
                        Text("Get Now",
                            style: blueTextFont.copyWith(fontSize: 12)),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(top: 40, bottom: 30),
                        child: isSignIn
                            ? SpinKitFadingCircle(
                                color: mainColor,
                              )
                            : FloatingActionButton(
                                elevation: 0,
                                backgroundColor: isEmailValid && isPasswordValid
                                    ? mainColor
                                    : Color(0xFFE4E4E4),
                                onPressed: isEmailValid && isPasswordValid
                                    ? () async {
                                        setState(() {
                                          isSignIn = true;
                                        });
                                      }
                                    : null,
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: isEmailValid && isPasswordValid
                                      ? Colors.white
                                      : Color(0xFFBEBEBE),
                                ),
                              ),
                      ),
                    ),
                    Row(
                      children: [
                        Text("Start Fresh Now? ",
                            style: greyTextFont.copyWith(
                                fontWeight: FontWeight.w400)),
                        SizedBox(
                          width: 0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                          },
                          child: Text("Sign Up", style: blueTextFont)
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
