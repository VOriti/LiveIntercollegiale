import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'src/web_view_stack.dart';

// commentato perché stiamo usando l'appbar invisibile.
// Decommentare per far funzionare quella con titolo e pulsanti
/*
import 'src/navigation_controls.dart';
 */

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
  late final WebViewController controllerGlobal;

Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      print("Pulsante indietro premuto");
      controllerGlobal.goBack();
      return Future.value(true);}
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Impossibile tornare ad una pagina precedente")),
      );
      return Future.value(false);
    }
  }

  @override
  void initState() {
    super.initState();
    controllerGlobal = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) //parametro aggiunto altrimenti non funziona nessuna pagina che utilizzi javascript
      ..loadRequest(
        Uri.parse('http://193.204.47.112/live/'),
      );
  }

 @override
  Widget build(BuildContext context) {
   return WillPopScope(
       onWillPop: () => _exitApp(context),
   child:  Scaffold(

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
          controller: controllerGlobal),
    )
       );
  }
}