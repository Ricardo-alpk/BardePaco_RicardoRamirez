import 'Producto.dart';

/// Representa una línea dentro de un pedido.
/// 
/// Vincula un [Producto] específico con la [cantidad] solicitada.

class ItemPedido {
  /// El producto seleccionado de la carta.
  final Producto producto;
  /// Número de unidades solicitadas de este producto.
  final int cantidad;

  const ItemPedido({
    required this.producto,
    required this.cantidad,
  });

  /// Calcula el precio total de esta línea (Precio unitario * Cantidad).
  double get subtotal {
    return producto.precio * cantidad;
  }

  /**Si fuera lambda seria:
   *  Como lambda sería:
   *  double get subtotal => producto.precio * cantidad;
   * 
   */
}
