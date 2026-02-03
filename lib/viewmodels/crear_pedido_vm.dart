import '../models/pedido.dart';
import '../models/item_pedido.dart';

/// ViewModel encargado de la lógica de negocio para crear un nuevo pedido.
/// 
/// Gestiona el estado temporal del formulario (nombre de mesa y lista de items)
/// antes de confirmar la creación del objeto [Pedido].
class CrearPedidoVm {
  /// Almacena el nombre de la mesa introducido por el usuario.
  String nombreMesa = '';
  
  /// Lista temporal de items seleccionados en la pantalla de selección.
  List<ItemPedido> itemsSelect = [];

  /// Getter para acceder a la lista de items seleccionados.
  List<ItemPedido> get itemsSeleccionados => itemsSelect;

  /// Actualiza el nombre de la mesa.
  void establecerMesa(String nombre) {
    nombreMesa = nombre;
  }

  /// Alias para establecer el nombre de la mesa.
  void nuevamesa(String nombre) {
    establecerMesa(nombre);
  }

  /// Reemplaza la lista actual de items con una nueva lista.
  void actualizarItems(List<ItemPedido> items) {
    itemsSelect = items;
  }
  
  void actualizarItem(List<ItemPedido> items) {
    actualizarItems(items);
  }

  /// Valida si el nombre de la mesa no está vacío o compuesto solo por espacios.
  bool get mesaEsOk {
    return nombreMesa.trim().isNotEmpty;
  }

  /// Valida si se ha seleccionado al menos un producto.
  bool get hayProductos {
    return itemsSelect.isNotEmpty;
  }

  /// Propiedad computada que indica si el pedido es válido para ser guardado.
  /// 
  /// Retorna `true` solo si [mesaEsOk] y [hayProductos] son verdaderos.
  bool get puedeGuardal {
    return mesaEsOk && hayProductos;
  }

  /// Alias para [puedeGuardal].
  bool get puedeGuardar => puedeGuardal;

  /// Calcula el precio total provisional de los items seleccionados actualmente.
  double get totalPrexio {
    double total = 0;
    for (var item in itemsSelect) {
      total += item.subtotal;
    }
    return total;
  }

  /// Alias para [totalPrexio].
  double get totalPrecio => totalPrexio;

  /// Construye y retorna una instancia final de [Pedido] con los datos actuales.
  Pedido hacerPedido() {
    return Pedido(
      mesa: nombreMesa.trim(),
      items: List<ItemPedido>.from(itemsSelect),
    );
  }

  /// Alias para [hacerPedido].
  Pedido construirPedido() => hacerPedido();
}