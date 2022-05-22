part of 'pages.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int timestamp = DateTime.now().millisecondsSinceEpoch;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DocumentModel> documents =
        Provider.of<DocumentProvider>(context).documents;
    List<ArticleModel> articles =
        Provider.of<ArticleProvider>(context).articles;
    auth.User user = Provider.of<auth.User>(context);

    int i = 0;

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
                      (user != null)
                          ? ("Hello, " +
                              user.email.replaceAll('@gmail.com', ''))
                          : "The dreamer",
                      style: blackTextFont.copyWith(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 26,
                      width: 26,
                      child: GestureDetector(
                        onTap: () => {
                          AuthServices.signOut(),
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StartPage()))
                        },
                        child: Icon(
                          MdiIcons.logout,
                          color: accentColor1,
                        ),
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
                      Text("A few hours ago",
                          style: whiteTextFont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          documents
                                  .where((element) =>
                                      int.parse(element.time) >=
                                      timestamp - 60 * 60 * 24 * 1000)
                                  .length
                                  .toString() +
                              " documents",
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
            documents.length > 0
                ? Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, bottom: 16, top: 16),
                    child: Text(
                      "Recent Documents",
                      style: blackTextFont.copyWith(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                : SizedBox(),
            documents.length > 0
                ? Container(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: documents.reversed.map((e) {
                        i++;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DocumentDetailPage(
                                        document: e, length: e.text.length)));
                          },
                          child: recentCard(
                              e.text.first, e.time, recentTime(e.time), i),
                        );
                      }).toList(),
                    ),
                  )
                : SizedBox(),
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
                children: articles.reversed.map((e) {
                  i++;
                  return articleCard(e);
                }).toList(),
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

  Container recentCard(String title, String time, String tag, int index) {
    // print(int.parse(time));
    return Container(
      height: 120,
      width: 120,
      margin: EdgeInsets.only(right: 16, left: index == 1 ? 20 : 0),
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
                DateFormat('dd MMM yyyy')
                    .format(DateTime.fromMicrosecondsSinceEpoch(
                        int.parse(time) * 1000))
                    .toString(),
                style: blackTextFont.copyWith(
                    fontSize: 12, fontWeight: FontWeight.w300),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget articleCard(ArticleModel e) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleDetailPage(
                      article: e,
                    )));
      },
      child: Container(
          // height: 100,
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
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Admin",
                      style: blackTextFont.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      e.title,
                      maxLines: 2,
                      style: blackTextFont.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
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
                          DateFormat('dd MMM yyyy, hh:mm a')
                              .format(DateTime.fromMicrosecondsSinceEpoch(
                                  int.parse(e.time) * 1000000))
                              .toString(),
                          style: blackTextFont.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                    image: DecorationImage(
                      image: NetworkImage(e.image),
                      fit: BoxFit.cover,
                    )),
              )
            ],
          )),
    );
  }
}
