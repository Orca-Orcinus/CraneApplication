import 'package:craneapplication/features/app_database.dart';
import 'package:craneapplication/features/dao/warehouse_dao.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// Only import `Value` from drift here to avoid symbol clashes with Flutter widgets
// Only import `Value` from drift here to avoid symbol clashes with Flutter widgets
import 'package:drift/drift.dart' show Value;
import 'package:intl/intl.dart';
import 'package:craneapplication/components/MyDrawer.dart';
import 'package:craneapplication/features/auth/firebasestore.dart';
import 'package:craneapplication/features/sync/sync_service.dart';

class WarehouseDataPage extends StatefulWidget {
  const WarehouseDataPage({super.key});

  @override
  State<WarehouseDataPage> createState() => _WarehouseDataPageState();
}

class _WarehouseDataPageState extends State<WarehouseDataPage> {
  // final WarehouseDatabaseController _dbController = WarehouseDatabaseController();
  final db = AppDatabase();
  late final WarehouseDao _warehouseDao;

  String _selectedFilter = 'all'; // all, pending, delivered, low_stock
  DateTime? _selectedDate;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // use the same DB instance for the DAO
    _warehouseDao = WarehouseDao(db);
  }

  Future<List<WarehouseItem>> _getFilteredWarehouses() async {
    List<WarehouseItem> items;

    switch (_selectedFilter) {
      case 'pending':
        items = await _warehouseDao.getWarehousesByOrderStatus('pending');
        break;
      case 'delivered':
        items = await _warehouseDao.getWarehousesByOrderStatus('delivered');
        break;
      case 'low_stock':
        items = await _warehouseDao.getLowStockItems();
        break;
      default:
        items = await _warehouseDao.getAll();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      items = items
        .where((item) =>
          item.itemName.toLowerCase().contains(q) ||
          (item.sku ?? '').toLowerCase().contains(q) ||
          (item.supplierName ?? '').toLowerCase().contains(q) ||
          (item.purchaseOrderNumber ?? '').toLowerCase().contains(q))
        .toList();
    }

    return items;
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warehouse Data Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            tooltip: 'Sync Now',
            onPressed: () async {
              final svc = SyncService(db, FireStoreService());
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sync started — please wait...')));
              try {
                await svc.syncAll();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sync finished')));
                setState(() {});
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sync failed: $e')));
              }
            },
          )
        ],
        elevation: 0,
      ),
      drawer: MyDrawer(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAddItemDialog(context),
          icon: const Icon(Icons.add),
          label: const Text('Add Item'),
        ),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                // Filter and Search Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Search Bar
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search by item name, SKU, supplier, or PO...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      // Filter Buttons
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildFilterButton('all', 'All Items'),
                            const SizedBox(width: 8),
                            _buildFilterButton('pending', 'Pending Orders'),
                            const SizedBox(width: 8),
                            _buildFilterButton('delivered', 'Delivered'),
                            const SizedBox(width: 8),
                            _buildFilterButton('low_stock', 'Low Stock'),
                            const SizedBox(width: 8),
                            ElevatedButton.icon(
                              onPressed: _selectDate,
                              icon: const Icon(Icons.calendar_today),
                              label: Text(
                                _selectedDate != null
                                    ? DateFormat('MMM dd, yyyy')
                                        .format(_selectedDate!)
                                    : 'Select Date',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Data Table
                Expanded(
                  child: FutureBuilder<List<WarehouseItem>>(
                    future: _getFilteredWarehouses(),
                    builder: (context, dataSnapshot) {
                      if (dataSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }
                      if (dataSnapshot.hasError) {
                        return Center(
                            child:
                                Text("Error: ${dataSnapshot.error}"));
                      }
                      if (!dataSnapshot.hasData ||
                          dataSnapshot.data!.isEmpty) {
                        return const Center(
                            child: Text("No warehouse data available"));
                      }

                      final items = dataSnapshot.data!;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            columns: const [
                              DataColumn(
                                  label: Text('Item Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('SKU',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('Supplier',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('Quantity',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('Unit Cost',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('Total Value',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('PO #',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('DO #',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('Order Status',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('Delivery Status',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('Payment Status',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              DataColumn(
                                  label: Text('Location',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                            ],
                            rows: items.map((item) {
                              return DataRow(
                                color: MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    // Highlight low stock items
                                    if (item.quantity <= item.minStockLevel) {
                                      return Colors.red.withOpacity(0.2);
                                    }
                                    // Alternate row colors
                                    return items.indexOf(item) % 2 == 0
                                        ? Colors.grey.withOpacity(0.1)
                                        : null;
                                  },
                                ),
                                cells: [
                                  DataCell(Text(item.itemName)),
                                  DataCell(Text(item.sku ?? '—')),
                                  DataCell(Text(item.supplierName ?? '—')),
                                  DataCell(
                                    Text(
                                      item.quantity.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: item.quantity <=
                                                item.minStockLevel
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                  ),
                                  DataCell(Text(
                                      '\$${item.unitCost.toStringAsFixed(2)}')),
                                  DataCell(Text(
                                      '\$${(item.quantity * item.unitCost).toStringAsFixed(2)}')),
                                  DataCell(Text(item.purchaseOrderNumber ?? '—')),
                                  DataCell(Text(
                                      item.deliveryOrderNumber ?? 'N/A')),
                                  DataCell(_buildStatusBadge(
                                      item.orderStatus, Colors.blue)),
                                  DataCell(_buildStatusBadge(
                                      item.deliveryStatus, Colors.orange)),
                                  DataCell(_buildStatusBadge(
                                      item.paymentStatus, Colors.green)),
                                  DataCell(Text(item.warehouseLocation ?? '—')),
                                ],
                                onSelectChanged: (_) {
                                  _showItemDetails(context, item);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("User not logged in"));
          }
        },
      ),
    );
  }

  Widget _buildFilterButton(String value, String label) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
      },
      backgroundColor: Colors.grey[200],
      selectedColor: Colors.blue[300],
    );
  }

  Widget _buildStatusBadge(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status.replaceAll('_', ' ').toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showItemDetails(BuildContext context, WarehouseItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(item.itemName),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                _buildDetailRow('SKU', item.sku ?? '—'),
                _buildDetailRow('Category', item.category ?? '—'),
                _buildDetailRow('Supplier', item.supplierName ?? '—'),
                _buildDetailRow('Contact', item.supplierContact ?? '—'),
                _buildDetailRow('Email', item.supplierEmail ?? '—'),
                _buildDetailRow('Phone', item.supplierPhone ?? '—'),
                const Divider(),
                _buildDetailRow('Quantity', item.quantity.toString()),
                _buildDetailRow(
                    'Min Stock Level', item.minStockLevel.toString()),
                _buildDetailRow(
                    'Max Stock Level', item.maxStockLevel.toString()),
                _buildDetailRow('Unit', item.unit),
                _buildDetailRow('Location', item.warehouseLocation ?? '—'),
                const Divider(),
                _buildDetailRow('Unit Cost', '\$${item.unitCost}'),
                _buildDetailRow('Total Value',
                    '\$${(item.quantity * item.unitCost).toStringAsFixed(2)}'),
                _buildDetailRow(
                  'PO Number', item.purchaseOrderNumber ?? '—'),
                _buildDetailRow(
                    'DO Number', item.deliveryOrderNumber ?? 'N/A'),
                _buildDetailRow('Order Status', item.orderStatus),
                _buildDetailRow('Delivery Status', item.deliveryStatus),
                _buildDetailRow('Payment Status', item.paymentStatus),
                _buildDetailRow('PO Date',
                    item.purchaseOrderDate != null
                        ? DateFormat('yyyy-MM-dd')
                            .format(item.purchaseOrderDate!)
                        : 'N/A'),
                _buildDetailRow('Expected Delivery',
                    item.expectedDeliveryDate != null
                        ? DateFormat('yyyy-MM-dd')
                            .format(item.expectedDeliveryDate!)
                        : 'N/A'),
                _buildDetailRow('Actual Delivery',
                    item.actualDeliveryDate != null
                        ? DateFormat('yyyy-MM-dd')
                            .format(item.actualDeliveryDate!)
                        : 'N/A'),
                if (item.notes != null && item.notes!.isNotEmpty) ...[
                  const Divider(),
                  _buildDetailRow('Notes', item.notes!),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Item'),
                    content: const Text(
                        'Are you sure you want to delete this item? This action cannot be undone.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  try {
                    await _warehouseDao.deleteItem(item);
                    if (mounted) {
                      Navigator.pop(context); // close details dialog
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Item deleted successfully')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to delete item: $e')),
                    );
                  }
                }
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showEditDialog(context, item);
              },
              child: const Text('Edit'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context,  WarehouseItem item) {
    final quantityController =
        TextEditingController(text: item.quantity.toString());
    final orderStatusController = TextEditingController(text: item.orderStatus);
    final deliveryStatusController =
        TextEditingController(text: item.deliveryStatus);
    final paymentStatusController =
        TextEditingController(text: item.paymentStatus);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit ${item.itemName}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: quantityController,
                  decoration:
                      const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: orderStatusController.text,
                  decoration:
                      const InputDecoration(labelText: 'Order Status'),
                  items: const [
                    DropdownMenuItem(value: 'pending', child: Text('Pending')),
                    DropdownMenuItem(
                        value: 'confirmed', child: Text('Confirmed')),
                    DropdownMenuItem(value: 'shipped', child: Text('Shipped')),
                    DropdownMenuItem(
                        value: 'delivered', child: Text('Delivered')),
                    DropdownMenuItem(
                        value: 'cancelled', child: Text('Cancelled')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      orderStatusController.text = value;
                    }
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: deliveryStatusController.text,
                  decoration:
                      const InputDecoration(labelText: 'Delivery Status'),
                  items: const [
                    DropdownMenuItem(
                        value: 'not_ordered', child: Text('Not Ordered')),
                    DropdownMenuItem(value: 'ordered', child: Text('Ordered')),
                    DropdownMenuItem(
                        value: 'in_transit', child: Text('In Transit')),
                    DropdownMenuItem(
                        value: 'delivered', child: Text('Delivered')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      deliveryStatusController.text = value;
                    }
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: paymentStatusController.text,
                  decoration:
                      const InputDecoration(labelText: 'Payment Status'),
                  items: const [
                    DropdownMenuItem(value: 'unpaid', child: Text('Unpaid')),
                    DropdownMenuItem(value: 'partial', child: Text('Partial')),
                    DropdownMenuItem(value: 'paid', child: Text('Paid')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      paymentStatusController.text = value;
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Item'),
                    content: const Text(
                        'Are you sure you want to delete this item? This action cannot be undone.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  try {
                    // item.id is non-null for DB rows (generated class), just delete
                    await _warehouseDao.deleteItem(item);
                    if (mounted) {
                      Navigator.pop(context); // close edit dialog
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Item deleted successfully')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to delete item: $e')),
                    );
                  }
                }
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final updatedItem = item.copyWith(
                    quantity: int.parse(quantityController.text),
                    orderStatus: orderStatusController.text,
                    deliveryStatus: deliveryStatusController.text,
                    paymentStatus: paymentStatusController.text,
                  );
                  await _warehouseDao.updateItem(updatedItem);
                  if (mounted) {
                    Navigator.pop(context);
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Item updated successfully')),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showAddItemDialog(BuildContext context) {
    final itemIdController = TextEditingController();
    final itemNameController = TextEditingController();
    final skuController = TextEditingController();
    final supplierController = TextEditingController();
    final quantityController = TextEditingController(text: '0');
    final unitCostController = TextEditingController(text: '0.0');
    final poController = TextEditingController();
    final doController = TextEditingController();
    final unitController = TextEditingController(text: 'pcs');
    final locationController = TextEditingController();
    final minController = TextEditingController(text: '0');
    final maxController = TextEditingController(text: '1000');
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Warehouse Item'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: itemIdController,
                  decoration: const InputDecoration(labelText: 'Item ID'),
                ),
                TextField(
                  controller: itemNameController,
                  decoration: const InputDecoration(labelText: 'Item Name'),
                ),
                TextField(
                  controller: skuController,
                  decoration: const InputDecoration(labelText: 'SKU'),
                ),
                TextField(
                  controller: supplierController,
                  decoration: const InputDecoration(labelText: 'Supplier Name'),
                ),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: unitCostController,
                  decoration: const InputDecoration(labelText: 'Unit Cost'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                TextField(
                  controller: poController,
                  decoration: const InputDecoration(labelText: 'Purchase Order #'),
                ),
                TextField(
                  controller: doController,
                  decoration: const InputDecoration(labelText: 'Delivery Order #'),
                ),
                TextField(
                  controller: unitController,
                  decoration: const InputDecoration(labelText: 'Unit (e.g. pcs)'),
                ),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                ),
                TextField(
                  controller: minController,
                  decoration: const InputDecoration(labelText: 'Min Stock Level'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: maxController,
                  decoration: const InputDecoration(labelText: 'Max Stock Level'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: notesController,
                  decoration: const InputDecoration(labelText: 'Notes'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final createdBy = FirebaseAuth.instance.currentUser?.uid ?? 'system';

                  final companion = WarehouseItemsCompanion(
                    itemId: Value(itemIdController.text.isNotEmpty
                        ? itemIdController.text
                        : DateTime.now().microsecondsSinceEpoch.toString()),
                    itemName: Value(itemNameController.text),
                    itemDescription: Value(''),
                    category: Value(''),
                    sku: Value(skuController.text.isNotEmpty ? skuController.text : null),
                    unitCost: Value(double.tryParse(unitCostController.text) ?? 0.0),
                    supplierName: Value(supplierController.text.isNotEmpty ? supplierController.text : null),
                    supplierContact: Value(''),
                    supplierEmail: Value(''),
                    supplierPhone: Value(''),
                    quantity: Value(int.tryParse(quantityController.text) ?? 0),
                    minStockLevel: Value(int.tryParse(minController.text) ?? 0),
                    maxStockLevel: Value(int.tryParse(maxController.text) ?? 1000),
                    unit: Value(unitController.text),
                    warehouseLocation: Value(locationController.text.isNotEmpty ? locationController.text : null),
                    purchaseOrderNumber: Value(poController.text.isNotEmpty ? poController.text : null),
                    deliveryOrderNumber: Value(doController.text.isNotEmpty ? doController.text : null),
                    orderStatus: Value('pending'),
                    deliveryStatus: Value('not_ordered'),
                    totalAmount: Value((double.tryParse(unitCostController.text) ?? 0.0) * (int.tryParse(quantityController.text) ?? 0)),
                    paymentStatus: Value('unpaid'),
                    createdBy: Value(createdBy),
                    notes: Value(notesController.text.isNotEmpty ? notesController.text : null),
                  );

                  await _warehouseDao.insertItem(companion);
                  if (mounted) {
                    Navigator.pop(context);
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Item added successfully')),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error adding item: $e')),
                  );
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
}