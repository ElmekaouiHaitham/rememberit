import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WordDetails extends StatelessWidget {
  final String url;
  const WordDetails(
      {Key? key,
      required this.url,
     })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: WebView(
          onPageStarted: (url) {
          },
          initialUrl:
              url,
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (url) {
            // here i will run the javascript code to perform something like scrapping and automation
          },
          onWebViewCreated: (controller) {},
          userAgent: 'Mozilla/5.0',
        ),
      ),
    );
  }
}
