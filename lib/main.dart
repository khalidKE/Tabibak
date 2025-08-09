import 'package:flutter/material.dart';
import 'package:tabibak/features/splash/view/splash_view.dart';


void main() {
  runApp( Tabibak());
}


//https://www.figma.com/design/BsBDK2TsI3XMEGeQn699Ge/Medics---Medical-App-UI-Kit--Community-?node-id=0-1&p=f&t=NUuC9KpBQfBGgm5X-0


class Tabibak extends StatelessWidget {
  const Tabibak({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),

    );
  }
}
