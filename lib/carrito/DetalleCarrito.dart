import 'dart:convert';

import 'package:carrito_v2/carrito/nps.dart';
import 'package:carrito_v2/main.dart';
import 'package:carrito_v2/models/Response.dart';
import 'package:flutter/material.dart';
import 'package:carrito_v2/carrito/carrito.dart';
import 'package:carrito_v2/utils/reusable_utils.dart';
import 'package:carrito_v2/models/items.dart';
import 'package:carrito_v2/utils/colors.dart';
import 'package:carrito_v2/Services/ServicioPreventa.dart';

class DetalleProductos extends StatefulWidget {
  const DetalleProductos({super.key, required this.title});

  final String title;

  @override
  State<DetalleProductos> createState() => _DetalleProductos();
}

class _DetalleProductos extends State<DetalleProductos> {
  var carro = new carrito();

  final ip_carrito = "192.168.0.19";
  var dropdownvalue = "";
  var ListPaymentMode = [
    "Seleccione Método de Pago",
    "Efectivo",
    "Tarjeta Debito/Crédito"
  ];
  final s = PreventaServices();
  //final ws = IOWebSocketChannel.connect(Uri.parse("ws://192.168.109.70:55555"));
  String res = "";

  /*Future<void> delay(int millis) async {
    await Future.delayed(Duration(milliseconds: millis));
  }*/

  /*void BuscaPreventa() {
    s.postBuscarVenta(jsonEncode({"ip_carrito": "192.168.0.19"}));
    delay(2000);
    res = s.ReturnValue;
  }*/

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    /*carro.agregarItem(1, "Pepsi lata 600ml", 0, 4.89);
    carro.agregarItem(2, "Coca Cola lata 600ml", 0, 5.89);
    carro.agregarItem(3, "Docena de Picarrones", 0, 22.00);*/
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: hexStringToColor("#198A6B"),
          foregroundColor: Colors.white,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            widget.title,
            textAlign: TextAlign.center,
          ),
          elevation: 0,
          toolbarHeight: 120,
        ),
        body: FutureBuilder(
          future: s.postListaCarrito(jsonEncode({
            "ip_carrito": ip_carrito,
            "codProducto": "",
            "cantidadVenta": 0,
            "eliminarprod": "false"
          })),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              //print(snapshot.data.lstProductos[0]["IdProducto"]);

              for (var itemadd in snapshot.data.lstProductos) {
                carro.agregarItem(
                    itemadd["IdProducto"].toString(),
                    itemadd["NombreProducto"].toString(),
                    int.parse(itemadd["CantidadCompra"].toString()),
                    double.parse(itemadd["PrecioCompra"].toString()));
              }

              return ListView(
                children: <Widget>[
                  ButtonIcon(context, () {
                    setState(() {});
                  }, Icons.refresh_outlined, "Refrescar carrito de compras"),
                  Container(
                    child: carro.numeroItems == 0
                        ? Center(
                            child: Text("Carrito Vacío"),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                                for (var item in carro.items)
                                  Card(
                                    margin: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                            child: Container(
                                          padding: EdgeInsets.all(5),
                                          height: 100,
                                          child: Column(children: <Widget>[
                                            Text(item.nomProducto),
                                            Text(
                                                "Q. ${item.PrecioVenta.toString()}"),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Container(
                                                  child: IconButton(
                                                    icon: Icon(Icons.remove,
                                                        size: 13,
                                                        color: Colors.white),
                                                    onPressed: () {
                                                      setState(() {
                                                        carro.decrementarCantidadItem(
                                                            item.CodProducto);

                                                        s.postListaCarrito(
                                                            jsonEncode({
                                                          "ip_carrito":
                                                              ip_carrito,
                                                          "codProducto":
                                                              item.CodProducto,
                                                          "cantidadVenta":
                                                              item.CantVenta,
                                                          "eliminarprod":
                                                              "false"
                                                        }));
                                                      });
                                                    },
                                                  ),
                                                  width: 50,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30))),
                                                ),
                                                Container(
                                                  child: Center(
                                                    child: Text(
                                                        item.CantVenta
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                ),
                                                Container(
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.add,
                                                      size: 13,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        carro.incrementarCantidadItem(
                                                            item.CodProducto);

                                                        s.postListaCarrito(
                                                            jsonEncode({
                                                          "ip_carrito":
                                                              ip_carrito,
                                                          "codProducto":
                                                              item.CodProducto,
                                                          "cantidadVenta":
                                                              item.CantVenta,
                                                          "eliminarprod":
                                                              "false"
                                                        }));
                                                      });
                                                    },
                                                  ),
                                                  width: 50,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30))),
                                                )
                                              ],
                                            )
                                          ]),
                                        )),
                                        Container(
                                          height: 100,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color: Color(0x99f0f0f0)),
                                          child: Column(children: <Widget>[
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Center(
                                                child: Text(
                                                    "Q. ${(item.PrecioVenta * item.CantVenta)}")),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Center(
                                              child: Container(
                                                child: IconButton(
                                                  icon: Icon(Icons.delete,
                                                      size: 13,
                                                      color: Colors.white),
                                                  onPressed: () {
                                                    setState(() {
                                                      carro.removerItem(
                                                          item.CodProducto);
                                                      s.postListaCarrito(
                                                          jsonEncode({
                                                        "ip_carrito":
                                                            ip_carrito,
                                                        "codProducto":
                                                            item.CodProducto,
                                                        "cantidadVenta": 0,
                                                        "eliminarprod": "true"
                                                      }));
                                                    });
                                                  },
                                                ),
                                                width: 50,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30))),
                                              ),
                                            )
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Row(children: <Widget>[
                                    Expanded(
                                        child: Text("SubTotal:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),
                                    Text(
                                        "Q. ${carro.subTotal.toStringAsFixed(2)}")
                                  ]),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Row(children: <Widget>[
                                    Expanded(
                                        child: Text("Impuesto:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),
                                    Text(
                                        "Q. ${carro.Impuesto.toStringAsFixed(2)}")
                                  ]),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Row(children: <Widget>[
                                    Expanded(
                                        child: Text("Total:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),
                                    Text("Q. ${carro.Total.toStringAsFixed(2)}")
                                  ]),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 600,
                                  child: DropdownButtonFormField(
                                    value: ListPaymentMode.first,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.9)),
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.payment_outlined,
                                          color: Colors.black),
                                      labelStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.9)),
                                      filled: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      fillColor: Colors.white.withOpacity(0.3),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none)),
                                    ),
                                    isExpanded: true,
                                    onChanged: (String? value) {
                                      dropdownvalue = value.toString();
                                    },
                                    onSaved: (String? value) {
                                      setState(() {
                                        dropdownvalue = value.toString();
                                      });
                                    },
                                    validator: (String? value) {
                                      if (value.toString().isEmpty) {
                                        return "can't empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: ListPaymentMode.map((String val) {
                                      return DropdownMenuItem(
                                        value: val,
                                        child: Text(
                                          val,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                ButtonIcon(
                                    context,
                                    () => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                                title: const Text(
                                                    "Finalizar Compra"),
                                                content: const Text(
                                                    "¿Desea Finalizar su Compra?"),
                                                actions: <Widget>[
                                                  TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context,
                                                              'Cancel'),
                                                      child: const Text("No")),
                                                  TextButton(
                                                      onPressed: () {
                                                        if (dropdownvalue ==
                                                                "Seleccione Método de Pago" ||
                                                            dropdownvalue ==
                                                                "") {
                                                          _showToast(
                                                              context,
                                                              "Método de Pago",
                                                              "Método de Pago Inválido.");
                                                          Navigator.pop(context,
                                                              'Cancel');
                                                        } else if (dropdownvalue ==
                                                            "Efectivo") {
                                                          /*for (var iteme in carro.items) {
                                                  carro.removerItem(
                                                      iteme.CodProducto);
                                                }*/
                                                          s.postFinalizarVenta(
                                                              jsonEncode({
                                                            "ip_carrito":
                                                                ip_carrito,
                                                            "precioTotal":
                                                                carro.Total == 0
                                                                    ? 1
                                                                    : carro
                                                                        .Total
                                                          }));
                                                          _showToast(
                                                              context,
                                                              "Método de Pago",
                                                              "Procesando Ticket.");
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          NpsCarrito(
                                                                            title:
                                                                                "Encuesta de Satisfacción",
                                                                          )));
                                                        } else {
                                                          _showToast(
                                                              context,
                                                              "Método de Pago",
                                                              "Solamente se aceptan pagos con efectivo, pago con tarjeta no disponible.");
                                                          Navigator.pop(context,
                                                              'Cancel');
                                                          /* Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            NpsCarrito(
                                                              title:
                                                                  "Encuesta de Satisfacción",
                                                            )));*/
                                                        }
                                                      },
                                                      child: const Text("Si")),
                                                ])),
                                    Icons.payment_outlined,
                                    "Pagar Compra"),
                                ButtonIcon(
                                    context,
                                    () => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                                title: const Text(
                                                    "Cancelar Compra"),
                                                content: const Text(
                                                    "¿Desea Cancelar su Compra?"),
                                                actions: <Widget>[
                                                  TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context,
                                                              'Cancel'),
                                                      child: const Text("No")),
                                                  TextButton(
                                                      onPressed: () {
                                                        for (var item
                                                            in carro.items)
                                                          carro.removerItem(
                                                              item.CodProducto);
                                                        s.postFinalizarVenta(
                                                            jsonEncode({
                                                          "ip_carrito":
                                                              ip_carrito
                                                        }));
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    MyHomePage(
                                                                        title:
                                                                            "Inicio")));
                                                      },
                                                      child: const Text("Si")),
                                                ])),
                                    Icons.remove_circle_outline,
                                    "Cancelar Compra"),
                                /* ButtonIcon(
                          context,
                          () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                      title: const Text("Nueva Compra"),
                                      content: const Text(
                                          "¿Desea Iniciar su Compra?"),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text("No")),
                                        TextButton(
                                            onPressed: () => {
                                                  for (var item in carro.items)
                                                    carro.removerItem(
                                                        item.codProducto),
                                                  _showToast(
                                                      context,
                                                      "Compra Iniciada",
                                                      "Gracias por Utilizar el Servicio de Compra...."),
                                                  Navigator.pop(
                                                      context, 'Cancel'),
                                                },
                                            child: const Text("Si")),
                                      ])),
                          Icons.add_circle_outline,
                          "Nueva Compra")*/
                              ]),
                  )
                ],
              );
            }
          },
        )

        // This trailing comma makes auto-formatting nicer for build methods.
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
