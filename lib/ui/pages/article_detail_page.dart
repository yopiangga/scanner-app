part of 'pages.dart';

class ArticleDetailPage extends StatelessWidget {
  ArticleModel article;

  ArticleDetailPage({this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: accentColor1,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Article",
            style: blackTextFont.copyWith(
                fontSize: 18, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          actions: [],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ListView(
              children: [
                Text(article.title,
                    style: blackTextFont.copyWith(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Container(
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 7,
                            blurRadius: 10,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        image: DecorationImage(
                            image: NetworkImage(article.image),
                            fit: BoxFit.cover))),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: article.description
                      .map((e) => Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Text(e,
                                style: blackTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                          ))
                      .toList(),
                )
              ],
            )));
  }
}
