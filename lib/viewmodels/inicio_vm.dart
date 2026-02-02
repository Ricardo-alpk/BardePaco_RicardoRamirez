import '../models/Producto.dart';
import '../models/item_pedido.dart';
import '../models/pedido.dart';

class InicioVm {
  final List<Pedido> pedidos = [
    Pedido(
      mesa: 'Mesa 1',
      items: [
        ItemPedido(producto: Producto.cartita[0], cantidad: 2),
        ItemPedido(producto: Producto.cartita[1], cantidad: 1),
      ],
    ),
  ];

  void agregarPedido(Pedido pedido) {
    pedidos.add(pedido);
  }
}
