import 'dart:async';
import 'dart:convert';

import 'package:carrito_v2/Services/ServicioPreventa.dart';
import 'package:carrito_v2/main.dart';
import 'package:carrito_v2/utils/reusable_utils.dart';
import 'package:flutter/material.dart';
import 'package:carrito_v2/utils/MyApp.dart.dart';

class NpsCarrito extends StatefulWidget {
  const NpsCarrito({super.key, required this.title});

  final String title;

  @override
  State<NpsCarrito> createState() => _NpsCarrito();
}

class _NpsCarrito extends State<NpsCarrito> {
  final _ComentariosController = TextEditingController();
  String comentario = "";
  int score = 0;
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
            children: <Widget>[
              SizedBox(
                height: 65,
              ),
              Text("Tu opinión es muy importante para nosotros.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                  )),
              SizedBox(
                height: 30,
              ),
              Text("¿Que te pareció nuestro carrito domótico?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                  )),
              SizedBox(
                height: 10,
              ),
              Row(children: <Widget>[
                SizedBox(
                  width: 70,
                ),
                IconButton(
                  key: const Key("btn1"),
                  onPressed: () {
                    score = 1;
                    _showToast(context, "Selección de punteo",
                        "Seleccionó carrita triste");
                  },
                  icon: const Icon(MyFlutterApp.frown_open),
                  color: Colors.red,
                  iconSize: 40,
                ),
                SizedBox(
                  width: 30,
                ),
                IconButton(
                  key: const Key("btn2"),
                  onPressed: () {
                    score = 5;
                    _showToast(context, "Selección de punteo",
                        "Seleccionó carita neutral");
                  },
                  icon: const Icon(MyFlutterApp.meh_1),
                  color: Colors.yellow,
                  iconSize: 40,
                ),
                SizedBox(
                  width: 30,
                ),
                IconButton(
                  key: const Key("btn3"),
                  onPressed: () {
                    score = 10;
                    _showToast(context, "Selección de punteo",
                        "Seleccionó carrita feliz");
                  },
                  icon: const Icon(MyFlutterApp.grin_beam),
                  color: Colors.green,
                  iconSize: 40,
                )
              ]),
              SizedBox(
                height: 40,
              ),
              Text("Ayudanos con tus comentarios.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                  )),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 50,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _ComentariosController,
                      autocorrect: false,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.comment_outlined, color: Colors.black45),
                        labelText: "Comentarios",
                        labelStyle: TextStyle(color: Colors.black),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: Colors.white.withOpacity(0.3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.solid)),
                      ),
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        comentario = value;
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ButtonIcon(
                  context,
                  () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                  "Confirmación de comentarios registrados"),
                              content: const Text(
                                  "Gracias por su compra y por sus comentario, esperamos que vuelva.."),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      final s = PreventaServices();
                                      s.postRegisterNps(jsonEncode({
                                        "Score": score,
                                        "Comentario": comentario
                                      }));
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyHomePage(title: "Inicio")));
                                    },
                                    child: const Text("Aceptar"))
                              ])),
                  Icons.send_outlined,
                  "Enviar Encuesta"),
            ],
          )),
    );
  }

  void _showToast(BuildContext context, String Label, String Message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(Message),
        action: SnackBarAction(
          label: Label,
          onPressed: scaffold.hideCurrentSnackBar,
          textColor: Colors.white,
        ),
      ),
    );
  }
}
