import 'dart:math';
import 'dart:ui';

Color whiteColor = const Color(0xffFFFFFF);
Color gunmetal = const Color(0xff2E2739);
Color blackColor = const Color(0xff202C43);
Color fontColor = const Color(0xff8F8F8F);
Color lightBlue = const Color(0xff61C3F2);
Color lightCream = const Color(0xffDBDBDF);
Color yellow = const Color(0xffCD9D0F);
Color blue = const Color(0xff564CA3);
Color primary = const Color(0xffF2F2F6);

Color gray25 = const Color(0xFFF8F8F8);
Color gray250 = const Color(0xFFCBCBCB);

Color gray75 = const Color(0xFFECECEC);
Color gray100 = const Color(0xFFE1E1E1);
Color gray50 = const Color(0xFFF1F1F1);
Color gray200 = const Color(0xFFEEEEEE);
Color gray220 = const Color(0xFFE1DFDF);
Color gray300 = const Color(0xFFACACAC);
Color gray400 = const Color(0xFF919191);
Color gray500 = const Color(0xFF6E6E6E);
Color gray600 = const Color(0xFF535353);
Color gray700 = const Color(0xFF616161);
Color gray800 = const Color(0xFF292929);
Color gray900 = const Color(0xFF212121);
Color gray950 = const Color(0xFF141414);

Color getRandomColor() {
  final Random random = Random();
  return Color.fromRGBO(
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
    1.0,
  );
}
