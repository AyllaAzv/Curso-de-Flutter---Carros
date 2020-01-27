import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SitePage extends StatelessWidget {
  WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Site"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _onClickRefresh,
          )
        ],
      ),
      body: WebView(
        initialUrl: "https://flutter.dev/",
        onWebViewCreated: (controller) {
          this.controller = controller;
        },
      ),
    );
  }

  _onClickRefresh() {
    this.controller.reload();
  }
}
