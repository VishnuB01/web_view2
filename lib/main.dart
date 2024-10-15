import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState(); 
}

class MyAppState extends State<MyApp> {


   WebViewController controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      
      onProgress: (int progress) {
        // Update loading bar.
      },

      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith('https://www.w3schools.com/')) {
          return NavigationDecision.prevent;
        }
        
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse('https://www.youtube.com/'));

void goBack() async{
  if(await controller.canGoBack()){
    await controller.goBack();
  }
}

void goForward() async{
  if(await controller.canGoForward()){
    await controller.goForward();
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Flutter Web View'),
    actions: [
      IconButton(onPressed: goBack, icon: Icon(Icons.arrow_back)),
      IconButton(onPressed: goForward, icon: Icon(Icons.arrow_forward))
    ],
    ),
    body: WebViewWidget(controller: controller),
  );
}
}
