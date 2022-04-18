part of 'widgets.dart';

class BTNDownloadWidget extends StatelessWidget {
  String title;
  dynamic onTap;

  BTNDownloadWidget({this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(color: mainColor),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.white,
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: () {
                onTap();
              },
              child: Center(
                child: Text(title,
                    style: whiteTextFont.copyWith(
                        fontWeight: FontWeight.w600, fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
