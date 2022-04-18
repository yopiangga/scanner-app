part of 'pages.dart';

class DocumentDetailPage extends StatefulWidget {
  DocumentModel document;
  DocumentDetailPage({this.document});

  @override
  State<DocumentDetailPage> createState() => _DocumentDetailPageState();
}

class _DocumentDetailPageState extends State<DocumentDetailPage> {
  bool textView = false;
  bool imageView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: accentColor1,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Maca Santara",
            style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                children: [
                  Text(
                    "Scan Result",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: accentColor1),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "You can play the sound of the scanned text, or also start a new scan",
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: accentColor1),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: ElevatedButton(child: Text("Scan Again")),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: ElevatedButton(child: Text("Result Audio")),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Expanded(
            //   child:
            Container(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.fromLTRB(20, 18, 20, 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: accentColor1.withOpacity(0.04),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.text_fields,
                                  color: mainColor,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Text",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: accentColor1.withOpacity(0.7)),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Text Scanner Result",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: accentColor1)),
                                  ],
                                ),
                              )),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    textView = !textView;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: mainColor),
                                  child: Icon(
                                    textView
                                        ? Icons.keyboard_arrow_down_rounded
                                        : Icons.chevron_right_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          textView
                              ? Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: Text(
                                    widget.document.text.last,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              : Container()
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.fromLTRB(20, 18, 20, 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: accentColor1.withOpacity(0.04),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.image_outlined,
                                  color: mainColor,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Take Image",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: accentColor1.withOpacity(0.7)),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("Image Result",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: accentColor1)),
                                  ],
                                ),
                              )),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    imageView = !imageView;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: mainColor),
                                  child: Icon(
                                    imageView
                                        ? Icons.keyboard_arrow_down_rounded
                                        : Icons.chevron_right_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          imageView && widget.document.image.last != null
                              ? Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: Image.file(widget.document.image.last))
                              : Container()
                        ],
                      )),
                ],
              ),
            ),
            // )
          ],
        ));
  }
}
