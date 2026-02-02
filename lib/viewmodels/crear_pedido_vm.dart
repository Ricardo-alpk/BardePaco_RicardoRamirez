import '../models/pedido.dart';
import '../models/item_pedido.dart';

class CrearPedidoVm {
  String nombreMesa = '';
  List<ItemPedido> itemsSelect = [];


  List<ItemPedido> get itemsSeleccionados => itemsSelect;

  void establecerMesa(String nombre) {
    nombreMesa = nombre;
  }

  
  void nuevamesa(String nombre) {
    establecerMesa(nombre);
  }

  void actualizarItems(List<ItemPedido> items) {
    itemsSelect = items;
  }

  
  void actualizarItem(List<ItemPedido> items) {
    actualizarItems(items);
  }

  bool get mesaEsOk {
    return nombreMesa.trim().isNotEmpty;
  }

  bool get hayProductos {
    return itemsSelect.isNotEmpty;
  }

  bool get puedeGuardal {
    return mesaEsOk && hayProductos;
  }

  bool get puedeGuardar => puedeGuardal;

  double get totalPrexio {
    double total = 0;
    for (var item in itemsSelect) {
      total += item.subtotal;
    }
    return total;
  }

  double get totalPrecio => totalPrexio;

  Pedido hacerPedido() {
    return Pedido(
      mesa: nombreMesa.trim(),
      items: List<ItemPedido>.from(itemsSelect),
    );
  }

  Pedido construirPedido() => hacerPedido();
}
