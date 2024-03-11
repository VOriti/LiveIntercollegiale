import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'src/navigation_controls.dart';
import 'src/web_view_stack.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: WebViewApp(),
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) //parametro aggiunto altrimenti non funziona nessuna pagina che utilizzi javascript
      ..loadRequest(
        Uri.parse('https://live.intercollegiale.it'),
      );
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(

//appbar predefinita con titolo e tasti di navigazione
/*       appBar: AppBar(
        title: const Text('Live Intercollegiale'),

        actions: [
          NavigationControls(controller: controller),
        ],
      ),
*/

// appbar nuova che evita la sovrapposizione con la barra di android ma non mostra nulla
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).padding.top),
        child: SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
      ),

      // corpo dello schermo
      body: WebViewStack(
          controller: controller),
    );
  }
}