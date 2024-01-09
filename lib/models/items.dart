import 'package:flutter/material.dart';

class Item {
  String CodProducto = "";
  String nomProducto = "";
  int CantVenta = 0;
  double PrecioVenta = 0;

  Item(String Codigo, String nombre, int Cantidad, double Precio) {
    this.CodProducto = Codigo;
    this.nomProducto = nombre;
    this.CantVenta = Cantidad;
    this.PrecioVenta = Precio;
  }
}
