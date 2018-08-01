import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

String url = "https://git-scm.com/book/en/v2";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Gitbook Unofficial',
      theme: ThemeData.dark(),
      routes: {
        "/": (_) => Home(),
        "/webview": (_) => WebviewScaffold(
              url: url,
              appBar: AppBar(
                title: Text("WebView"),
              ),
              withJavascript: true,
              withLocalStorage: true,
              withZoom: true,
            ),
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final webView = FlutterWebviewPlugin();
  TextEditingController controller = TextEditingController(text: url);

  @override
  void initState() {
    super.initState();

    webView.close();
    controller.addListener(() {
      url = controller.text;
    });
  }

  @override
  void dispose() {
    webView.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Webview"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: controller,
              ),
            ),
            RaisedButton(
              child: Text("OPEN"),
              onPressed: () {
                Navigator.of(context).pushNamed("/webview");
              },
            )
          ],
        ),
      ),
    );
  }
}
