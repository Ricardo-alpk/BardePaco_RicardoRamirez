import 'item_pedido.dart';

class Pedido {
  final String mesa;
  final List<ItemPedido> items;

  const Pedido({
    required this.mesa,
    required this.items,
  });

  int get totalDeProductos {
    int total = 0;
    for (var item in items) {
      total += item.cantidad;
    }
    return total;
  }

  double get totalDePrecio {
    double total = 0;
    for (var item in items) {
      total += item.subtotal;
    }
    return total;
  }
}
