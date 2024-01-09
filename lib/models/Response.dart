import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carrito_v2/models/items.dart';

ResponseProductos responseProductosToJson(String str) =>
    ResponseProductos.fromJson(json.decode(str));

class Response {
  int CodRes = 0;
  String msgRes = "";
  String GuidVenta = "";

  Response(int cod, String msg, String guid) {
    this.CodRes = cod;
    this.msgRes = msg;
    this.GuidVenta = guid;
  }

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(json["CodRes"], json["msgRes"], json["GuidVenta"]);
  }
}

class Producto {
  String IdProducto = "";
  String NombreProducto = "";
  int CantidadCompra = 0;
  double PrecioCompra = 0.00;
  double DescuenctoProducto = 0.00;
  String ImagenProducto = "";
}

class ResponseProductos {
  int CodRes;
  String msgRes;
  String GuidVenta;
  List<dynamic> lstProductos;

  ResponseProductos(
      {required this.CodRes,
      required this.msgRes,
      required this.GuidVenta,
      required this.lstProductos});

  factory ResponseProductos.fromJson(Map<String, dynamic> json) {
    return ResponseProductos(
        CodRes: json["CodRes"],
        msgRes: json["msgRes"],
        GuidVenta: json["GuidVenta"],
        lstProductos: json["lstProductos"]);
  }
}

class ResponseNps {
  int codRes = 0;
  String msgRes = "";
}
