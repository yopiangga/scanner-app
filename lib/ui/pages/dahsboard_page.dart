part of 'pages.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    List<DocumentModel> documents =
        Provider.of<DocumentProvider>(context).documents;
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Container(
                margin:
                    EdgeInsets.only(left: 20, bottom: 10, right: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hallo, Yopiangga",
                      style: blackTextFont.copyWith(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 26,
                      width: 26,
                      child: Icon(
                        MdiIcons.bellOutline,
                        color: accentColor1,
                      ),
                    ),
                  ],
                )),
            Container(
              width: double.infinity,
              height: 120,
              margin: EdgeInsets.only(left: 20, bottom: 10, right: 20, top: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: mainColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Today",
                          style: whiteTextFont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                      SizedBox(
                        height: 20,
                      ),
                      Text(documents.length.toString() + " documents",
                          style: whiteTextFont.copyWith(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                      image: AssetImage("assets/images/grade.png"),
                    )),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 16, top: 16),
              child: Text(
                "Recent Documents",
                style: blackTextFont.copyWith(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: documents
                    .map((e) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DocumentDetailPage(
                                          document: e,
                                        )));
                          },
                          child: recentCard(e.text.first, e.time, "Recent App"),
                        ))
                    .toList(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 16, top: 20),
              child: Text(
                "Articles",
                style: blackTextFont.copyWith(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Column(
                children: [
                  articleCard(),
                  articleCard(),
                  articleCard(),
                  articleCard(),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }

  Container recentCard(String title, String time, String tag) {
    return Container(
      height: 120,
      width: 120,
      margin: EdgeInsets.only(left: 16),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: mainColor.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tag,
            style: blackTextFont.copyWith(
                fontSize: 12, fontWeight: FontWeight.w300),
          ),
          Text(
            title,
            maxLines: 3,
            style: blackTextFont.copyWith(
                fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 7,
                width: 7,
                decoration: BoxDecoration(
                  color: mainColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                time,
                style: blackTextFont.copyWith(
                    fontSize: 12, fontWeight: FontWeight.w300),
              )
            ],
          )
        ],
      ),
    );
  }

  Container articleCard() {
    return Container(
        height: 100,
        width: double.infinity,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              spreadRadius: 4,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent App",
                  style: blackTextFont.copyWith(
                      fontSize: 12, fontWeight: FontWeight.w300),
                ),
                Text(
                  "Create two ad banners",
                  style: blackTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 7,
                      width: 7,
                      decoration: BoxDecoration(
                        color: mainColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "10 Mei 2022",
                      style: blackTextFont.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w300),
                    )
                  ],
                )
              ],
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[100]),
            )
          ],
        ));
  }
}
