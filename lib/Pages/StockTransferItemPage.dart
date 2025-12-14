import 'package:flutter/material.dart';
import '../Model/StockManagementModel/StockTransferModel.dart';
import '../Model/WarehouseTool/StockTransferItem.dart';
import 'package:craneapplication/components/MyDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StockTransferItemPage extends StatefulWidget {
  const StockTransferItemPage({super.key});

  @override
  State<StockTransferItemPage> createState() => _StockTransferItemState();
}

class _StockTransferItemState extends State<StockTransferItemPage> {
  final StockTransferController _stockTransferControler = StockTransferController();

  String _selectedFilter = 'all'; // all, in_stock, out_of_stock
  String _searchQuery = ''; //itemGroup search query

  @override
  void initState() {
    super.initState();
  }  

  Future<List<StockTransferModel>> _fetchFilteredStockItems() async {
    // Implement filtering logic based on _selectedFilter and _searchQuery
    List<StockTransferModel> allItems;

    switch(_selectedFilter) {
      case 'all':
      default:
        // Fetch all items
        allItems = await _stockTransferControler.fetchAllStockTransfers();
        break;
    }

    if(_searchQuery.isNotEmpty)
    {
      final q = _searchQuery.toLowerCase();
      allItems = allItems.where((item) => item.itemCode.toLowerCase().contains(q)).toList();
    }

    return allItems;
  }

  Widget _buildFilterButton(String value,String label)
  {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected){
        setState(() {
          _selectedFilter = value;
        });
      },
      backgroundColor: Colors.grey[200],
      selectedColor: Colors.blue[300],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 120,
              child:
                Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)
                ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context,StockTransferModel item)
  {
    final itemDescriptionControlller = TextEditingController(text: item.itemDescription);
    final fromLocationController = TextEditingController(text: item.fromLocation);
    final toLocationController = TextEditingController(text: item.toLocation);
    final uomController = TextEditingController(text: item.unitOfMeasurement);
    final quantityTransferredController = TextEditingController(text: item.quantityTransferred.toString());

    showDialog(
      context: context,
      builder: (BuildContext context)
      {
        return AlertDialog(
          title: const Text("Edit Stock Received Item"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: itemDescriptionControlller,
                  decoration: const InputDecoration(labelText: "Item Description"),
                ),
                TextField(
                  controller: fromLocationController,
                  decoration: const InputDecoration(labelText: "From Location"),                  
                ),
                TextField(
                  controller: toLocationController,
                  decoration: const InputDecoration(labelText: "To Location"),
                ),
                TextField(
                  controller: uomController,
                  decoration: const InputDecoration(labelText: "Unit of Measurement"),
                ),
                TextField(
                  controller: quantityTransferredController,
                  decoration: const InputDecoration(labelText: "Quantity Transferred"),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                try{
                  final updatedItem = StockTransferModel(
                    itemCode: item.itemCode,
                    itemDescription: itemDescriptionControlller.text,
                    fromLocation: fromLocationController.text,
                    toLocation: toLocationController.text,
                    quantityTransferred: double.tryParse(quantityTransferredController.text) ?? 0.0,
                    unitOfMeasurement: uomController.text,
                  );
                  await _stockTransferControler.updateStockTransfer(updatedItem);
                  if(mounted)
                  {
                    Navigator.of(context).pop();
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Transfer item updated successfully")),
                      );
                    });
                  }
                }
                catch (e)
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error updating transfer item: $e")),
                  );
                }            
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _showItemDetails(BuildContext context, StockTransferModel item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Item Details: ${item.itemCode}"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow("Item Code", item.itemCode),
                _buildDetailRow("Description", item.itemDescription), 
                _buildDetailRow("From Location", item.fromLocation),
                _buildDetailRow("To Location", item.toLocation), 
                _buildDetailRow("Unit of Measurement", item.unitOfMeasurement),
                _buildDetailRow("Quantity Transffered", item.quantityTransferred.toStringAsFixed(2)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
            TextButton(
              onPressed: () async{
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Confirm Deletion"),
                      content: const Text("Are you sure you want to delete this transfer item?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("Delete"),
                        ),
                      ],
                    );
                  },
                );
                if(confirm == true)
                {
                  try{
                    await _stockTransferControler.deleteStockTransfer(item);
                    if(mounted)
                    {
                      Navigator.of(context).pop(); // Close details dialog
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Transfer item deleted successfully")),
                        );
                      });
                    }
                  }
                  catch (e)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error deleting transfer item: $e")),
                    );
                  } 
                }
              },
                child: const Text("Delete",style:TextStyle(color:Colors.red)
              ),
            ),
            ElevatedButton(
              onPressed: ()
              {
                Navigator.of(context).pop(); // Close details dialog
                _showEditDialog(context,item);
              },
              child: const Text("Edit"),
            ),
          ],
        );
      },
    );
  }

  void _showAddItemDialog(BuildContext context) {
    final _itemCodeController = TextEditingController();
    final _itemDescriptionController = TextEditingController();
    final _fromLocationController = TextEditingController();
    final _toLocationController = TextEditingController();
    final _quantityController = TextEditingController();
    final _uomController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Stock Item"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _itemCodeController,
                  decoration: const InputDecoration(labelText: "Item Code"),
                ),
                TextField(
                  controller: _itemDescriptionController,
                  decoration: const InputDecoration(labelText: "Item Description"),
                ),
                TextField(
                  controller: _fromLocationController,
                  decoration: const InputDecoration(labelText: "From Location"),                  
                ),
                TextField(
                  controller: _toLocationController,
                  decoration: const InputDecoration(labelText: "To Location"),
                ),
                TextField(
                  controller: _uomController,
                  decoration: const InputDecoration(labelText: "Unit of Measurement"),
                ),
                TextField(
                  controller: _quantityController,
                  decoration: const InputDecoration(labelText: "Quantity Transferred"),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                try{
                  final newItem = StockTransferModel(
                    itemCode: _itemCodeController.text,
                    itemDescription: _itemDescriptionController.text,
                    fromLocation: _fromLocationController.text,
                    toLocation: _toLocationController.text,
                    unitOfMeasurement: _uomController.text,
                    quantityTransferred: double.tryParse(_quantityController.text) ?? 0.0,
                  );
                  await _stockTransferControler.addStockTransfer(newItem);
                  if(mounted)
                  {
                    Navigator.of(context).pop();
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Transfer item added successfully")),
                      );
                    });
                  }
                }
                catch (e)
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error adding transfer item: $e")),
                  );
                }            
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Stock Transfer Data"),
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()  => _showAddItemDialog(context),
        icon: const Icon(Icons.add),
        label: const Text("Add Transfer Item"),
        ),
      body: StreamBuilder(
        stream:  FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot)
        {
          if(snapshot.connectionState == ConnectionState.active)
          {
            if(snapshot.hasData)
            {
              return Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                        hintText: "Search by Item Code",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: 
                        const EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      onChanged: (value) 
                      {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                      const SizedBox(height: 12),                

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildFilterButton('all', 'All'),
                            const SizedBox(width: 8),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child:FutureBuilder<List<StockTransferModel>>(
                    future: _fetchFilteredStockItems(),
                    builder: (context,snapshot)
                    {
                      if(snapshot.connectionState == ConnectionState.waiting)
                      {
                        return const Center(child: CircularProgressIndicator());
                      }
                      else if(snapshot.hasError)
                      {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      }
                      else if(!snapshot.hasData || snapshot.data!.isEmpty)
                      {
                        return const Center(child: Text("No stock items found."));
                      }
                      else
                      {
                        final stockItems = snapshot.data!;
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: RefreshIndicator(
                            onRefresh:() async {
                              await _fetchFilteredStockItems();
                              },
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: DataTable(
                                columns: const [
                                  DataColumn(label: Text('Item Code',style:TextStyle(fontWeight:FontWeight.bold))),
                                  DataColumn(label: Text('Description',style:TextStyle(fontWeight:FontWeight.bold))),
                                  DataColumn(label: Text('From Location',style:TextStyle(fontWeight:FontWeight.bold))),
                                  DataColumn(label: Text('To Location',style:TextStyle(fontWeight:FontWeight.bold))),
                                  DataColumn(label: Text('UOM',style:TextStyle(fontWeight:FontWeight.bold))),
                                  DataColumn(label: Text('Quantity Transferred',style:TextStyle(fontWeight:FontWeight.bold))),
                                ],
                                rows: stockItems.map((item) {
                                  return DataRow(cells: [
                                    DataCell(Text(item.itemCode)),
                                    DataCell(Text(item.itemDescription)),
                                    DataCell(Text(item.fromLocation)),
                                    DataCell(Text(item.toLocation)),
                                    DataCell(Text(item.unitOfMeasurement)),
                                    DataCell(Text(item.quantityTransferred.toStringAsFixed(2))),
                                  ],
                                  onSelectChanged: (_)
                                  {
                                    _showItemDetails(context,item);
                                  }
                                  );
                                }).toList(),
                              ),
                            ),                            
                          ),
                        );                        
                      }
                    },
                  ),
                ),
              ],
              );
            }
            else
            {
              return const Center(child: Text("User not logged in"));
            }
          }
          else
          {
            return const Center(child: CircularProgressIndicator());
          }
        }),
    );
  }
}