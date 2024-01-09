import 'dart:async';
import 'package:carrito_v2/carrito/DetalleCarrito.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const DetalleProductos(
                      title: "Detalle de Productos",
                    ))));
  }

  @override
  Widget build(BuildContext context) {
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
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
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
      ),
    );
  }
}
