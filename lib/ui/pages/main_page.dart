part of 'pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavBarIndex;
  PageController pageController;
  bool loading = false;

  @override
  void initState() {
    super.initState();

    bottomNavBarIndex = 0;
    pageController = PageController(initialPage: bottomNavBarIndex);
  }

  @override
  Widget build(BuildContext context) {
    List<DocumentModel> documents =
        Provider.of<DocumentProvider>(context).documents;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: accentColor1,
          ),
          SafeArea(
            child: Container(
              color: Color(0xFFF6F7F9),
            ),
          ),
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                bottomNavBarIndex = index;
              });
            },
            children: [DashboardPage(), DocumentsPage()],
          ),
          loading
              ? Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: SpinKitWave(
                        color: mainColor, type: SpinKitWaveType.start),
                  ),
                )
              : Container(),
          createCustomBottomNavBar(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 46,
              height: 46,
              margin: EdgeInsets.only(bottom: 42),
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: mainColor,
                onPressed: () async {
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
                      id: "add",
                      time: "123",
                      uid: "yopiangga",
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
                            builder: (context) => DocumentDetailPage(
                                  document: documents.last,
                                )));
                  }
                },
                child: SizedBox(
                  height: 26,
                  width: 26,
                  child: Icon(
                    MdiIcons.plus,
                    color: Colors.white.withOpacity(1),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget createCustomBottomNavBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipper: BottomNavBarClipper(),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedItemColor: mainColor,
            unselectedItemColor: Color(0xFFE5E5E5),
            currentIndex: bottomNavBarIndex,
            onTap: (index) {
              setState(() {
                bottomNavBarIndex = index;
                pageController.jumpToPage(index);
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Container(
                    child: SizedBox(
                      height: 26,
                      width: 26,
                      child: Icon(
                        MdiIcons.viewDashboard,
                        color: (bottomNavBarIndex == 0)
                            ? mainColor
                            : accentColor1.withOpacity(0.7),
                      ),
                    ),
                    height: 20,
                    margin: EdgeInsets.only(bottom: 6),
                  ),
                  label: "Dashboard"),
              BottomNavigationBarItem(
                  icon: Container(
                    child: SizedBox(
                      height: 26,
                      width: 26,
                      child: Icon(
                        MdiIcons.fileDocumentMultiple,
                        color: (bottomNavBarIndex == 1)
                            ? mainColor
                            : accentColor1.withOpacity(0.7),
                      ),
                    ),
                    height: 20,
                    margin: EdgeInsets.only(bottom: 6),
                  ),
                  label: "My Documents"),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavBarClipper extends CustomClipper<Path> {
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width / 2 - 28, 0);
    path.quadraticBezierTo(size.width / 2 - 28, 33, size.width / 2, 33);
    path.quadraticBezierTo(size.width / 2 + 28, 33, size.width / 2 + 28, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
