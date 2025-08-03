import 'package:flutter/material.dart';
import 'package:simple_loading/simple_loading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Simple Loading Example',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Loading Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                /// Default Lottie Loader--->>
                SimpleLoading.show(context, seconds: 3);
              },
              child: const Text('Show Lottie Loading'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                /// Circular Loader-->
                SimpleLoading.show(context, loadingType: Type.circular);
                Future.delayed(const Duration(seconds: 3), () {
                  SimpleLoading.close();
                });
              },
              child: const Text('Show Circular Loading'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Linear loader--->>
                SimpleLoading.show(context, loadingType: Type.linear);
                Future.delayed(const Duration(seconds: 3), () {
                  SimpleLoading.close();
                });
              },
              child: const Text('Show Linear Loading'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // cupertino loader--->>
                SimpleLoading.show(context,
                    loadingType: Type.cupertino,
                    indicatorColor: Colors.amberAccent,
                    seconds: 2);
              },
              child: const Text('Show cupertino Loading'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // refresh loader--->>
                SimpleLoading.show(context,
                    loadingType: Type.refresh, seconds: 2);
              },
              child: const Text('Show refresh Loading'),
            ),
          ],
        ),
      ),
    );
  }
}
