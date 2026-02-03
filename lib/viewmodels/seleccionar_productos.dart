import '../models/Producto.dart';
import '../models/item_pedido.dart';

/// ViewModel que gestiona la lógica de selección de productos y cantidades.
/// 
/// Utiliza un mapa interno para llevar la cuenta de cuántas unidades de cada
/// [Producto] se han seleccionado.
class SeleccionarProductosVM {
  
  /// Referencia a la lista estática de productos disponibles.
  final List<Producto> carta = Producto.cartita;

  /// Mapa que almacena la cantidad seleccionada por cada producto.
  final Map<Producto, int> cantidades = {};

  /// Devuelve la cantidad actual seleccionada para un producto específico.
  /// Si no existe en el mapa, devuelve 0.
  int cantidadProducto(Producto producto) {
    return cantidades[producto] ?? 0;
  }

  /// Incrementa en 1 la cantidad del producto indicado.
  void aumentar(Producto producto) {
    final actual = cantidadProducto(producto);
    cantidades[producto] = actual + 1;
  }

  /// Disminuye en 1 la cantidad del producto.
  /// 
  /// Si la cantidad llega a 0, elimina el producto del mapa de selección.
  void disminuir(Producto producto) {
    final actual = cantidadProducto(producto);
    if (actual <= 1) {
      cantidades.remove(producto);
    } else {
      cantidades[producto] = actual - 1;
    }
  }

  /// Convierte el mapa de estado interno en una lista de objetos [ItemPedido].
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

  /// Calcula el total provisional de la selección actual.
  double get total {
    double total = 0;
    cantidades.forEach((producto, cantidad) {
      total += producto.precio * cantidad;
    });
    return total;
  }
}