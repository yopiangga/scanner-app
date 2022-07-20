part of 'pages.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    auth.User user = Provider.of<auth.User>(context);
    final _documents = Provider.of<DocumentProvider>(context);
    List<DocumentModel> documents = _documents.documents;

    // print(shareUID);
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
              Text("Read & Learn anything with\n Si Maca App",
                  style: greyTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center),
              Container(
                width: 250,
                height: 46,
                margin: EdgeInsets.only(top: 70),
                child: ElevatedButton(
                  child: Text("Get Started",
                      style: whiteTextFont.copyWith(fontSize: 16)),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(mainColor),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                user != null ? MainPage() : SignInPage()));
                  },
                ),
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  final result = await pickImage();

                  if (result == false || result == null) {
                    setState(() {
                      loading = false;
                    });
                    return;
                  } else {
                    DocumentModel document = DocumentModel(
                      id: "1",
                      time: "0",
                      uid: "non-login",
                    );

                    document.text.add(result[0]);
                    document.image.add(result[1]);

                    setState(() {
                      documents.add(document);
                      loading = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DocumentPage(
                                  document: documents.last,
                                )));
                  }
                },
                child: Container(
                  width: 250,
                  height: 46,
                  margin: EdgeInsets.only(top: 15, bottom: 19),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: mainColor),
                  ),
                  child: Center(
                    child: loading
                        ? SpinKitWave(
                            color: mainColor,
                            type: SpinKitWaveType.start,
                            size: 16,
                          )
                        : Text("Login as Guest",
                            style: whiteTextFont.copyWith(
                                fontSize: 16, color: mainColor)),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Start Fresh Now? ",
                      style:
                          greyTextFont.copyWith(fontWeight: FontWeight.w400)),
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
                      child: Text("Sign Up", style: blueTextFont))
                ],
              )
            ]),
      ),
    );
  }
}
