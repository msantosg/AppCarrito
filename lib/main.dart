import 'package:carrito_v2/carrito/splashscreen.dart';
import 'package:carrito_v2/utils/reusable_utils.dart';
import 'package:flutter/material.dart';
import 'package:carrito_v2/Services/ServicioPreventa.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final txtNit = TextEditingController();
  String valueText = "";
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 247, 250, 248),
                Color.fromARGB(255, 249, 252, 251),
                Color.fromARGB(255, 253, 255, 253),
              ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Center(
                  child: Text(
                    "CestaSmart",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 38,
                        color: Colors.red),
                  ),
                ),
                Center(
                  child: Text(
                    "Compra inteligente",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 38,
                        color: Colors.red),
                  ),
                ),
                Center(
                  child: Text(
                    "ahorra tiempo",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 38,
                        color: Colors.red),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                      "Convierte la compra en una experiencia rápida y sencilla.",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.grey.shade400)),
                ),
                Center(
                  child: Text("Nuestra App te permite ahorrar tiempo,",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.grey.shade400)),
                ),
                Center(
                  child: Text(" descubrir promociones y tener todo",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.grey.shade400)),
                ),
                Center(
                  child: Text("lo que necesitas al alcance de tus dedos",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.grey.shade400)),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/images/gifcarro.png!bw700",
                  height: 200.0,
                  width: 200.0,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ButtonIcon2(context, () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Ingrese su Nit'),
                      content: TextField(
                        onChanged: (value) {
                          setState(() {
                            valueText = value;
                          });
                        },
                        controller: txtNit,
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.edit_document, color: Colors.black45),
                          labelText: "Nit...",
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.white.withOpacity(0.3),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.solid)),
                        ),
                      ),
                      actions: <Widget>[
                        MaterialButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          child: const Text('Cancelar'),
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                        ),
                        MaterialButton(
                          color: Colors.green,
                          textColor: Colors.white,
                          child: Text('Aceptar'),
                          onPressed: () {
                            setState(() {
                              final s = PreventaServices();
                              String json = jsonEncode({
                                "nit_cliente": valueText.replaceAll("-", ""),
                                "ip_carrito": "192.168.0.19"
                              });

                              final response = s.postRegisterPreventa(json);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SplashScreen()));
                            });
                          },
                        ),
                      ],
                    );
                  });
            }, Icons.shopping_bag_outlined, "Iniciar compra"),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "CestaSmart V1.0GT",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
            Center(
              child: Text(
                "Derechos Reservados - The Chiefs Of PM ${DateTime.now().year}",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
