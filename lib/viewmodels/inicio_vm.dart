import '../models/Producto.dart';
import '../models/item_pedido.dart';
import '../models/pedido.dart';

/// ViewModel principal que mantiene el estado global de la aplicación.
/// 
/// Almacena la lista de todos los [pedidos] realizados.
class InicioVm {
  /// Lista de pedidos activos en el bar.
  /// Inicia con un pedido de ejemplo predefinido.
  final List<Pedido> pedidos = [
    Pedido(
      mesa: 'Mesa 1',
      items: [
        ItemPedido(producto: Producto.cartita[0], cantidad: 2),
        ItemPedido(producto: Producto.cartita[1], cantidad: 1),
      ],
    ),
  ];

  /// Añade un nuevo [pedido] a la lista de pedidos activos.
  void agregarPedido(Pedido pedido) {
    pedidos.add(pedido);
  }
}