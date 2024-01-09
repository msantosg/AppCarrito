import 'dart:convert';
import 'dart:ffi';

import 'package:carrito_v2/models/items.dart';
import 'package:http/http.dart' as http;
import 'package:carrito_v2/models/Response.dart';

class PreventaServices {
  String url = "http://192.168.0.11/ApiRestCarritoPi/api/";

  Future<String> postRegisterPreventa(String Json) async {
    var uri = Uri.parse(url + "TransaccionesCarrito/AgregarEncabezadoPreventa");
    final headers = {"Content-Type": "application/json;charset=UTF-8"};
    var response = await http.post(uri, headers: headers, body: Json);
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final json = jsonDecode(body);
      final resp = Response(0, "", "");
      resp.CodRes = json["CodRes"];
      resp.msgRes = json["msgRes"];
      resp.GuidVenta = json["GuidVenta"];
      return resp.GuidVenta;
    } else {
      return "";
    }
  }

  Future<ResponseNps> postRegisterNps(String json) async {
    var uri = Uri.parse(url + "TransaccionesCarrito/Nps");
    final headers = {"Content-Type": "application/json;charset=UTF-8"};
    var response = await http.post(uri, headers: headers, body: json);
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final json = jsonDecode(body);
      final resp = ResponseNps();
      resp.codRes = json["codRes"];
      resp.msgRes = json["msgRes"];
      return resp;
    } else {
      throw Exception("Fallo en la conexión");
    }
  }

  Future<Response> postFinalizarVenta(String json) async {
    var uri = Uri.parse(url + "TransaccionesCarrito/FinalizarPreventa");
    final headers = {"Content-Type": "application/json;charset=UTF-8"};
    var response = await http.post(uri, headers: headers, body: json);
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final json = jsonDecode(body);
      final resp = Response(0, "", "");
      resp.CodRes = json["CodRes"];
      resp.msgRes = json["msgRes"];
      resp.GuidVenta = json["GuidVenta"];
      return resp;
    } else {
      throw Exception("Fallo en la conexión");
    }
  }

  Future<String> postBuscarVenta(String Json) async {
    var uri = Uri.parse(url + "TransaccionesCarrito/BuscarGuidVenta");
    final headers = {"Content-Type": "application/json;charset=UTF-8"};
    var response = await http.post(uri, headers: headers, body: Json);
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final json = jsonDecode(body);
      final resp = Response(0, "", "");
      resp.CodRes = json["CodRes"];
      resp.msgRes = json["msgRes"];
      resp.GuidVenta = json["GuidVenta"];

      ReturnValue = resp.GuidVenta;
      Future.delayed(Duration(milliseconds: 10000));
      return resp.GuidVenta;
    } else {
      throw Exception("Fallo en la conexión");
    }
  }

  Future<ResponseProductos> postListaCarrito(String Json) async {
    var uri = Uri.parse(url + "TransaccionesCarrito/BuscaProductos");
    final headers = {"Content-Type": "application/json;charset=UTF-8"};
    var response = await http.post(uri, headers: headers, body: Json);
    if (response.statusCode == 200) {
      return responseProductosToJson(response.body);
    } else {
      throw Exception("Fallo en la conexión");
    }
  }

  String ReturnValue = "";
}
