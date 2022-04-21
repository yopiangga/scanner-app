part of 'pages.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(shareUID);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 136,
                decoration: BoxDecoration(
                  // color: Colors.grey[200]
                  image: DecorationImage(
                    image: AssetImage('assets/images/start-animation.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 70, bottom: 16),
                child: Text(
                  "New Experience",
                  style: blackTextFont.copyWith(fontSize: 20),
                ),
              ),
              Text("Read & Learn anything with\n Maca Santara App",
                  style: greyTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center),
              Container(
                width: 250,
                height: 46,
                margin: EdgeInsets.only(top: 70, bottom: 19),
                child: ElevatedButton(
                  child: Text("Get Started",
                      style: whiteTextFont.copyWith(fontSize: 16)),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(mainColor),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MainPage()));
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ",
                      style:
                          greyTextFont.copyWith(fontWeight: FontWeight.w400)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInPage()));
                    },
                    child: Text("Sign in",
                        style: blueTextFont.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
