import '../models/Producto.dart';
import '../models/item_pedido.dart';

class SeleccionarProductosVM {
  
  //La lista se llama Cartita
  final List<Producto> carta = Producto.cartita;

  final Map<Producto, int> cantidades = {};

  //esto devuelve la cantidad seleccionada del producto que se a elegido, obviamente
  int cantidadProducto(Producto producto) {
    return cantidades[producto] ?? 0;
  }

  //esto hace mas uno del producto
  void aumentar(Producto producto) {
    final actual = cantidadProducto(producto);
    cantidades[producto] = actual + 1;
  }

  void disminuir(Producto producto) {
    final actual = cantidadProducto(producto);
    if (actual <= 1) {
      cantidades.remove(producto);
    } else {
      cantidades[producto] = actual - 1;
    }
  }

  List<ItemPedido> construirItems() {
    return cantidades.entries
        .map(
          (e) => ItemPedido(
            producto: e.key,
            cantidad: e.value,
          ),
        )
        .toList();
  }

  double get total {
    double total = 0;
    cantidades.forEach((producto, cantidad) {
      total += producto.precio * cantidad;
    });
    return total;
  }
}
