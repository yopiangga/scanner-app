part of 'pages.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({Key key}) : super(key: key);

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  @override
  Widget build(BuildContext context) {
    List<DocumentModel> documents =
        Provider.of<DocumentProvider>(context).documents;
    return Scaffold(
      body: Container(
          child: ListView(
        children: [
          Container(
              margin: EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Documents",
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
                                builder: (context) => SignInPage()))
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
            child: Column(
              children: documents.reversed
                  .map((e) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocumentDetailPage(
                                      document: e, length: e.text.length)));
                        },
                        child: documentCard(e.text.first, e.time, "Recent App"),
                      ))
                  .toList(),
            ),
          ),
          SizedBox(
            height: 80,
          )
        ],
      )),
    );
  }

  Container documentCard(String title, String time, String tag) {
    // print(time);
    // print(timestamp);
    // print((int.parse(time) - timestamp) / 1000);
    return Container(
        // height: 180,
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    recentTime(time),
                    style: blackTextFont.copyWith(
                        fontSize: 12, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    title,
                    maxLines: 4,
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
                                int.parse(time) * 1000))
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
              height: 10,
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[100]),
              child: Icon(
                MdiIcons.book,
                color: mainColor,
              ),
            )
          ],
        ));
  }
}
