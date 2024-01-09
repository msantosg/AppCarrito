import 'package:flutter/material.dart';
import 'package:carrito_v2/models/items.dart';

class carrito extends ChangeNotifier {
  //Map<String, Item> _Items = {};
  List<Item> _Items = [];
  List<Item> get items {
    return _Items;
  }

  int get numeroItems {
    return _Items.length;
  }

  double get subTotal {
    var total = 0.00;
    /*items.forEach(
        (key, value) => total += value.precioProducto * value.cantidadCompra);*/
    for (int i = 0; i < items.length; i++)
      total += items[i].PrecioVenta * items[i].CantVenta;

    return total;
  }

  double get Impuesto {
    var total = 0.00;
    total = this.subTotal * 0.12;
    return total;
  }

  double get Total {
    var total = 0.00;
    total = Impuesto + subTotal;
    return total;
  }

  void agregarItem(String codigo, String nombre, int cantidad, double precio) {
    /*if (_Items.containsKey(codigo)) {
      _Items.update(
          codigo,
          (old) => Item(
              codProducto: old.codProducto,
              nomProducto: old.nomProducto,
              cantidadCompra: old.cantidadCompra + 1,
              precioProducto: old.precioProducto));
    } else {
      _Items.putIfAbsent(
          codigo,
          () => Item(
              codProducto: codigo,
              nomProducto: nombre,
              cantidadCompra: 1,
              precioProducto: precio));
    }*/

    /*for (int i = 0; i < _Items.length; i++) {
      if (_Items[i].codProducto == codigo) {
        _Items[i].cantidadCompra += 1;
        return;
      }
    }*/
    if (_Items.where((element) => element.CodProducto == codigo).isNotEmpty)
      _Items.firstWhere((element) => element.CodProducto == codigo).CantVenta =
          cantidad;
    else
      _Items.add(Item(codigo, nombre, cantidad, precio));
  }

  void removerItem(String codigo) {
    //_Items.removeWhere((element) => element.codProducto == codigo);
    _Items.removeWhere((element) => element.CodProducto == codigo);
  }

  void incrementarCantidadItem(String codigo) {
    /*if (_Items[codigo]!.cantidadCompra > 1) {
      _Items.update(
          codigo,
          (old) => Item(
              codProducto: old.codProducto,
              nomProducto: old.nomProducto,
              cantidadCompra: old.cantidadCompra + 1,
              precioProducto: old.precioProducto));
    }*/
    _Items.firstWhere((element) => element.CodProducto == codigo).CantVenta +=
        1;
    /*for (int i = 0; i < _Items.length; i++) {
      if (_Items[i].codProducto == codigo) {
        _Items[i].cantidadCompra += 1;
        return;
      }
    }*/
  }

  void decrementarCantidadItem(String codigo) {
    /*if (!_Items.containsKey(codigo)) return;
    if (_Items[codigo]!.cantidadCompra > 1) {
      _Items.update(
          codigo,
          (old) => Item(
              codProducto: old.codProducto,
              nomProducto: old.nomProducto,
              cantidadCompra: old.cantidadCompra - 1,
              precioProducto: old.precioProducto));
    } else
      removerItem(codigo);*/

    if (_Items.where((element) => element.CodProducto == codigo).isEmpty)
      return;

    /*for (int i = 0; i < _Items.length; i++) {
      if (_Items[i].codProducto == codigo) {
        if (_Items[i].cantidadCompra > 1) {
          _Items[i].cantidadCompra -= 1;
          return;
        } else {
          removerItem(_Items[i].codProducto);
          return;
        }
      }
    }*/
    if (_Items.firstWhere((element) => element.CodProducto == codigo)
            .CantVenta >=
        1)
      _Items.firstWhere((element) => element.CodProducto == codigo).CantVenta -=
          1;
    else
      removerItem(codigo);
  }
}
