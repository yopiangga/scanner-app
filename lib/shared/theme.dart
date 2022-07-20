part of 'shared.dart';

const double defaultMargin = 24;

// Color mainColor = Color(0xff4265D6);
Color mainColor = Color(0xff5b21b6);
Color accentColor1 = Color(0xFF023047);
Color accentColor2 = Color(0xFFADADAD);

TextStyle blackTextFont = GoogleFonts.raleway()
    .copyWith(color: accentColor1, fontWeight: FontWeight.w500);
TextStyle whiteTextFont = GoogleFonts.raleway()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);
TextStyle blueTextFont = GoogleFonts.raleway()
    .copyWith(color: mainColor, fontWeight: FontWeight.w500);
TextStyle greyTextFont = GoogleFonts.raleway()
    .copyWith(color: accentColor2, fontWeight: FontWeight.w500);

TextStyle whiteNumberFont =
    GoogleFonts.openSans().copyWith(color: Colors.white);
