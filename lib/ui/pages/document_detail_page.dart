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
  bool getData = true;

  FlutterTts tts = FlutterTts();

  initState() {
    super.initState();
    tts.setLanguage('en-US');
    tts.setSpeechRate(0.4);
  }

  void dispose() {
    super.dispose();
    tts.stop();
    audioPlayer.stop();
  }

  playAudio(String text) async {
    tts.speak(text);
  }

  int statusPlayer = 0;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    final _language = Provider.of<LanguageProvider>(context);
    List<LanguageModel> language = _language.items;

    if (getData) {
      tts.setLanguage(_language.selectedKey);
    }

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

                final resJob =
                    await ProsaServices.submitTTS(widget.document.text);
                final jobId = jsonDecode(resJob.body)['job_id'];

                widget.document.job_id = jobId;

                final result =
                    await DocumentServices.editDocument(widget.document);
                if (result != null) {
                  _showMaterialTextDialog();
                }
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
                  : widget.length != widget.document.text.length
                      ? Icon(MdiIcons.contentSave)
                      : SizedBox(),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        bottomNavigationBar: Container(
            height: 70,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: isLoading
                ? SpinKitWave(color: mainColor, type: SpinKitWaveType.start)
                : BTNAddWidget(
                    title: "Add Page",
                    onTap: () => {
                      setState(() {
                        isLoading = true;
                      }),
                      onAdd()
                    },
                  )),
        body: ListView(shrinkWrap: true, children: [
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
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
              child: Row(children: [
                BTNExpandedIconWidget(
                    callback: () async {
                      setState(() {
                        statusPlayer = 0;
                      });
                      // print(statusPlayer);
                      audioPlayer.stop();
                    },
                    status: statusPlayer == 0 ? false : true,
                    icon: MdiIcons.stopCircle),
                SizedBox(width: 10),
                BTNExpandedIconWidget(
                    callback: () async {
                      if (statusPlayer == 1) return;
                      if (statusPlayer == 2) {
                        audioPlayer.resume();
                      } else {
                        String path = await ProsaServices.retriveTTS(
                            job_id: widget.document.job_id);
                        if(path == ""){
                          return;
                        }
                        audioPlayer.play(path);
                      }
                      setState(() {
                        statusPlayer = 1;
                      });
                    },
                    status: statusPlayer == 1 ? false : true,
                    icon: MdiIcons.playCircle),
                SizedBox(width: 10),
                BTNExpandedIconWidget(
                    callback: () async {
                      setState(() {
                        statusPlayer = 2;
                      });
                      await audioPlayer.pause();
                    },
                    status:
                        (statusPlayer == 2 || statusPlayer == 0) ? false : true,
                    icon: MdiIcons.pauseCircle),
              ])),
          ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: widget.document.text.length,
              itemBuilder: (context, index) => GestureDetector(
                    child: Container(
                        // height: expand ? double.infinity : 110,
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            left: 20, right: 20, bottom: 20, top: 0),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.08),
                              spreadRadius: 4,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
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
                                    child: (audioIndex == index)
                                        ? Icon(
                                            Icons.stop_circle_outlined,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            Icons.record_voice_over_rounded,
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
                  ))
        ]));
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

  void _showMaterialTextDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)), //this right here
            child: Container(
              height: 180,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text("Success Upload",
                            style: blackTextFont.copyWith(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text(
                          "Your document has been successfully uploaded",
                          textAlign: TextAlign.center,
                          style: blackTextFont.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(color: mainColor),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(14.0),
                                  primary: Colors.white,
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
