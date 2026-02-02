import 'Producto.dart';

class ItemPedido {
  final Producto producto;
  final int cantidad;

  const ItemPedido({
    required this.producto,
    required this.cantidad,
  });

  double get subtotal {
    return producto.precio * cantidad;
  }

  /**Si fuera lambda seria:
   *  Como lambda sería:
   *  double get subtotal => producto.precio * cantidad;
   * 
   */
}
