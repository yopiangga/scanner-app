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
  int expandedIndex = -1;
  bool isLoading = false;

  FlutterTts tts = FlutterTts();

  initState() {
    super.initState();
    tts.setLanguage('en-US');
    tts.setSpeechRate(0.4);
  }

  void dispose() {
    super.dispose();
    tts.stop();
  }

  playAudio(String text) async {
    tts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: accentColor1,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Detail Document",
            style: blackTextFont.copyWith(
                fontSize: 16, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () async {
                final result =
                    await DocumentServices.editDocument(widget.document);
              },
              child: Icon(
                MdiIcons.check,
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        bottomNavigationBar: Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: isLoading
                ? SpinKitWave(color: mainColor, type: SpinKitWaveType.start)
                : BTNDownloadWidget(
                    title: "Add Page",
                    onTap: () => {
                      setState(() {
                        isLoading = true;
                      }),
                      onAdd()
                    },
                  )),
        body: ListView.builder(
            itemCount: widget.document.text.length,
            itemBuilder: (context, index) => GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      if (expandedIndex == index) {
                        expandedIndex = -1;
                      } else {
                        expandedIndex = index;
                      }
                    });
                  },
                  child: Container(
                      // height: expand ? double.infinity : 110,
                      width: double.infinity,
                      margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 20,
                          top: index == 0 ? 20 : 0),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "#" + (index + 1).toString(),
                                      style: blackTextFont.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      widget.document.text[index],
                                      maxLines: 2,
                                      style: blackTextFont.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 5),
                                    // Row(
                                    //   crossAxisAlignment: CrossAxisAlignment.center,
                                    //   children: [
                                    //     Container(
                                    //       height: 7,
                                    //       width: 7,
                                    //       decoration: BoxDecoration(
                                    //         color: mainColor,
                                    //         shape: BoxShape.circle,
                                    //       ),
                                    //     ),
                                    //     SizedBox(
                                    //       width: 5,
                                    //     ),
                                    //     Text(
                                    //       "10:12",
                                    //       style: blackTextFont.copyWith(
                                    //           fontSize: 12, fontWeight: FontWeight.w300),
                                    //     )
                                    //   ],
                                    // )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  playAudio(widget.document.text[index]);
                                  print("TTS");
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[100]),
                                  child: Icon(
                                    MdiIcons.speaker,
                                    color: Colors.grey[400].withOpacity(1),
                                  ),
                                ),
                              )
                            ],
                          ),
                          expandedIndex == index
                              ? SizedBox(height: 10)
                              : SizedBox(),
                          expandedIndex == index
                              ? Text(
                                  widget.document.text[index],
                                  style: blackTextFont.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                              : SizedBox()
                        ],
                      )),
                )));
  }

  dynamic onAdd() async {
    setState(() {
      isLoading = true;
    });
    final result = await pickImage();

    if (result == false || result == null) {
      setState(() {
        isLoading = false;
      });
      return;
    } else {
      setState(() {
        widget.document.text.add(result[0]);
        widget.document.image.add(result[1]);
        isLoading = false;
      });
    }
  }
}
