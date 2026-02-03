import 'item_pedido.dart';

/// Representa un pedido completo asociado a una mesa.
/// 
/// Contiene el identificador de la [mesa] y la lista de [items] solicitados.
class Pedido {
  /// Nombre o identificador de la mesa (Ej: "Mesa 1").
  final String mesa;
  
  /// Lista de productos y cantidades que componen el pedido.
  final List<ItemPedido> items;

  const Pedido({
    required this.mesa,
    required this.items,
  });

  /// Calcula la suma total de productos (unidades) en el pedido.
  int get totalDeProductos {
    int total = 0;
    for (var item in items) {
      total += item.cantidad;
    }
    return total;
  }

  /// Calcula el coste total del pedido sumando el subtotal de todos los items.
  double get totalDePrecio {
    double total = 0;
    for (var item in items) {
      total += item.subtotal;
    }
    return total;
  }
}