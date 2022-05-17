part of 'pages.dart';

class DocumentDetailPage extends StatefulWidget {
  DocumentModel document;
  int length;
  DocumentDetailPage({this.document, this.length});

  @override
  State<DocumentDetailPage> createState() => _DocumentDetailPageState();
}

class _DocumentDetailPageState extends State<DocumentDetailPage> {
  bool textView = false;
  bool imageView = false;
  int expandedIndex = -1;
  int audioIndex = -1;
  bool isLoading = false;
  bool isSave = false;

  FlutterTts tts = FlutterTts();

  initState() {
    super.initState();
    tts.setLanguage('id-ID');
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
    // final _documents = Provider.of<DocumentProvider>(context);
    // List<DocumentModel> documents = _documents.documents;

    // print(widget.length);
    // print(widget.document.text.length);

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
                  setState(() {
                    isSave = true;
                  });
                  final result =
                      await DocumentServices.editDocument(widget.document);
                  setState(() {
                    widget.length = widget.document.text.length;
                    isSave = false;
                  });
                },
                child: isSave
                    ? SpinKitWave(
                        color: mainColor,
                        type: SpinKitWaveType.start,
                        size: 16,
                      )
                    : Icon(
                        widget.length != widget.document.text.length
                            ? MdiIcons.contentSave
                            : MdiIcons.check,
                      )),
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
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (expandedIndex == index) {
                                        expandedIndex = -1;
                                      } else {
                                        expandedIndex = index;
                                      }
                                    });
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (audioIndex == index) {
                                    tts.stop();
                                  } else {
                                    playAudio(widget.document.text[index]);
                                  }

                                  // print("TTS");
                                  setState(() {
                                    if (audioIndex == index) {
                                      audioIndex = -1;
                                    } else {
                                      audioIndex = index;
                                    }
                                  });
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: (audioIndex == index)
                                          ? Colors.grey[400]
                                          : mainColor),
                                  child: Icon(
                                    MdiIcons.speaker,
                                    color: Colors.white,
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
