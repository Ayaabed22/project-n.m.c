// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// class WebViewScreen extends StatelessWidget {
//   final String? url;
//   const WebViewScreen ({Key? key, required this.url}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(),
//         body: WebView(initialUrl:url,
//         javascriptMode: JavascriptMode.unrestricted,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class luncherScreen extends StatefulWidget {
  Uri? UrlLink;
   luncherScreen ({Key? key,required this.UrlLink}) : super(key: key);

  @override
  State<luncherScreen> createState() => _luncherScreenState();
}

class _luncherScreenState extends State<luncherScreen> {

  @override
  Widget build(BuildContext context) {
    launchUrl(UrlLink) async{
      if(await canLaunchUrl(UrlLink)){
      }
      else{
        throw "Coudelnt Lunch $UrlLink";
      }
    }
    return Scaffold(

    );
  }
}
