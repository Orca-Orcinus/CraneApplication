import 'dart:io';

import 'package:craneapplication/Model/StockManagementModel/StockKeepingModel.dart';
import 'package:craneapplication/Model/WarehouseTool/StockKeepingItem.dart';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:craneapplication/components/MyDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StockWarehousePage extends StatefulWidget {
  const StockWarehousePage({super.key});

  @override
  State<StockWarehousePage> createState() => _StockWarehouseState();
}

class _StockWarehouseState extends State<StockWarehousePage> {
  final StockKeepingItem _stockKeepingController = StockKeepingItem();

  String _selectedFilter = 'all'; // all, in_stock, out_of_stock
  String _searchQuery = ''; //itemGroup search query

  @override
  void initState() {
    super.initState();
  }  

  Future<List<StockKeepingModel>> _fetchFilteredStockItems() async {
    // Implement filtering logic based on _selectedFilter and _searchQuery
    List<StockKeepingModel> allItems;

    switch(_selectedFilter) {
      case 'all':
      default:
        // Fetch all items
        allItems = await _stockKeepingController.fetchAllWarehouseItem();
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

  void _showEditDialog(BuildContext context,StockKeepingModel item)
  {
    final itemDescriptionControlller = TextEditingController(text: item.itemDescription);
    final itemSku = TextEditingController(text: item.sku);
    final itemCategory = TextEditingController(text: item.category);
    final itemUnitCost = TextEditingController(text: item.unitCost.toString());
    final itemQuantity = TextEditingController(text: item.quantity.toString());
    final itemMinStockLevel = TextEditingController(text: item.minStockLevel.toString());
    final itemMaxStockLevel = TextEditingController(text: item.maxStockLevel.toString());
    final uomController = TextEditingController(text: item.unitOfMeasurement);
    final createdBy = TextEditingController(text: item.createdBy);

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
                  controller: itemSku,
                  decoration: const InputDecoration(labelText: "Item Sku"),                  
                ),
                TextField(
                  controller: itemCategory,
                  decoration: const InputDecoration(labelText: "Item Category"),
                ),
                TextField(
                  controller: itemUnitCost,
                  decoration: const InputDecoration(labelText: "Item Unit Cost"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: itemQuantity,
                  decoration: const InputDecoration(labelText: "Item Quantity"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: itemMinStockLevel,
                  decoration: const InputDecoration(labelText: "Item Min Stock Level"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: itemMaxStockLevel,
                  decoration: const InputDecoration(labelText: "Item Max Stock Level"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: uomController,
                  decoration: const InputDecoration(labelText: "Unit of Measurement"),
                ),
                TextField(
                  controller: createdBy,
                  decoration: const InputDecoration(labelText: "Created By"),
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
                  final updatedItem = StockKeepingModel(
                    itemCode: item.itemCode,
                    itemDescription: itemDescriptionControlller.text,
                    category: itemCategory.text,
                    unitCost: double.tryParse(itemUnitCost.text) ?? 0.0,
                    minStockLevel: int.tryParse(itemMinStockLevel.text) ?? 0,
                    maxStockLevel: int.tryParse(itemMaxStockLevel.text) ?? 0,
                    quantity: double.tryParse(itemQuantity.text) ?? 0.0,
                    sku:itemSku.text,
                    unitOfMeasurement: uomController.text,
                    createdBy: item.createdBy,
                  );
                  await _stockKeepingController.updateStockKeeping(updatedItem);
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

  void _showItemDetails(BuildContext context, StockKeepingModel item) {
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
                _buildDetailRow("sku", item.sku),
                _buildDetailRow("Item Category", item.category), 
                _buildDetailRow("Unit Cost", item.unitCost.toStringAsFixed(2)),
                _buildDetailRow("Min Stock Level", item.minStockLevel.toStringAsFixed(1)),
                _buildDetailRow("Max Stock Level", item.maxStockLevel.toStringAsFixed(1)),
                _buildDetailRow("Quantity Count", item.quantity.toStringAsFixed(1)),
                _buildDetailRow("Unit of Measurement", item.unitOfMeasurement),
                _buildDetailRow("Created By", item.createdBy),
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
                    await _stockKeepingController.deleteStockKeeping(item);
                    if(mounted)
                    {
                      Navigator.of(context).pop(); // Close details dialog
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Stock item deleted successfully")),
                        );
                      });
                    }
                  }
                  catch (e)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error deleting stock item: $e")),
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
    final itemCodeController = TextEditingController();
    final itemDescriptionControlller = TextEditingController();
    final itemSku = TextEditingController();
    final itemCategory = TextEditingController();
    final itemUnitCost = TextEditingController();
    final itemQuantity = TextEditingController();
    final uomController = TextEditingController();
    final itemMinStockLevel = TextEditingController();
    final itemMaxStockLevel = TextEditingController();
    final createdBy = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Stock Item"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: itemCodeController,
                  decoration: const InputDecoration(labelText: "Item Code"),
                ),
                TextField(
                  controller: itemDescriptionControlller,
                  decoration: const InputDecoration(labelText: "Item Description"),
                ),
                TextField(
                  controller: itemSku,
                  decoration: const InputDecoration(labelText: "Item Sku"),                  
                ),
                TextField(
                  controller: itemCategory,
                  decoration: const InputDecoration(labelText: "Item Category"),
                ),
                TextField(
                  controller: itemUnitCost,
                  decoration: const InputDecoration(labelText: "Item Unit Cost"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: itemQuantity,
                  decoration: const InputDecoration(labelText: "Item Quantity"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: itemMinStockLevel,
                  decoration: const InputDecoration(labelText: "Item Min Stock Level"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: itemMaxStockLevel,
                  decoration: const InputDecoration(labelText: "Item Max Stock Level"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: uomController,
                  decoration: const InputDecoration(labelText: "Unit of Measurement"),
                ),
                TextField(
                  controller: createdBy,
                  decoration: const InputDecoration(labelText: "Created By"),
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
                  final newItem = StockKeepingModel(
                    itemCode: itemCodeController.text,
                    itemDescription: itemDescriptionControlller.text,
                    category: itemCategory.text,
                    unitCost: double.tryParse(itemUnitCost.text) ?? 0.0,
                    minStockLevel: int.tryParse(itemMinStockLevel.text) ?? 0,
                    maxStockLevel: int.tryParse(itemMaxStockLevel.text) ?? 0,
                    quantity: double.tryParse(itemQuantity.text) ?? 0.0,
                    sku:itemSku.text,
                    unitOfMeasurement: uomController.text,
                    createdBy: createdBy.text,
                  );
                  await _stockKeepingController.addStockKeeping(newItem);
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
            ElevatedButton(onPressed: () async
            {
              _importFromFile(context);
            },
            child: const Text("Import Data"))
          ],
        );
      },
    );
  }

  Future<void> _importFromFile(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv','xlsx'],
        withData: true,
      );

      if(result == null) return; //user termination

      final file = result.files.single;
      final extension = file.extension?.toLowerCase();
      final bytes = file.bytes ?? await File(file.path!).readAsBytes();

      List<List<dynamic>> parsedRows = [];

      if(extension == "csv")
      {
        final csvString = String.fromCharCodes(bytes);

        parsedRows = const CsvToListConverter(eol: "\n",shouldParseNumbers: false,).convert(csvString);
      }
      else if(extension == "xlsx")
      {
        final excel = Excel.decodeBytes(bytes);
        final sheet = excel.tables.values.first;

        for(final row in sheet.rows)
        {
          parsedRows.add(row.map((cell) => cell?.value).toList());
        }
      }
      else
      {
        throw Exception("Unsupported File Type.");
      }

      final headers = _buildHeaderIndex(parsedRows[0]);

      String? currentItemCode;
      String currentItemDescription = "";

      for (int i = 2; i < parsedRows.length; i++) {
        final row = parsedRows[i];

        final itemCode = row[headers["Item Code"]!]?.toString().trim();
        final description = row[headers["Description"]!]?.toString().trim() ?? "";

        // If this row has an item code, commit previous item and start new
        if (itemCode != null && itemCode.isNotEmpty) {

          // Save previous item before starting new one
          if (currentItemCode != null) {
            final priceCell = row[headers["Price"]!];
            final qtyCell = row[headers["QTY"]!];
            final newItem = StockKeepingModel(
              itemCode: currentItemCode,
              itemDescription: currentItemDescription, 
              sku: '',
              category: '', 
              unitCost: _toDouble(priceCell),
              quantity: _toDouble(qtyCell), 
              minStockLevel: 0, 
              maxStockLevel: 0, 
              unitOfMeasurement: row[headers["UOM"]!]?.toString() ?? '', 
              createdBy: '',
            );

            await _stockKeepingController.addStockKeeping(newItem);
          }

          // Start new item
          currentItemCode = itemCode;
          currentItemDescription = description;

        } else {
          // No item code → append description to previous item
          if (description.isNotEmpty && currentItemCode != null) {
            currentItemDescription += " $description";
          }
        }
      }

      // Save the last item after loop ends
      if (currentItemCode != null) {
        final lastRow = parsedRows.last;
        final priceCell = parsedRows[headers["Price"]!];
        final qtyCell = parsedRows[headers["QTY"]!];
        final newItem = StockKeepingModel(
          itemCode: currentItemCode,
          itemDescription: currentItemDescription,
          sku: '',
          category: '', 
          unitCost: _toDouble(priceCell),
          quantity: _toDouble(qtyCell),
          minStockLevel: 0, 
          maxStockLevel: 0, 
          unitOfMeasurement: lastRow[headers["UOM"]!]?.toString() ?? '', 
          createdBy: '',
        );

        await _stockKeepingController.addStockKeeping(newItem);
      }


    } catch (e) {
      if(!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to import CSV:$e")));
      print(e);
    }
  }

  double _toDouble(dynamic cell) {
    if (cell == null) return 0.0;
    if (cell is num) return cell.toDouble();
    return double.tryParse(cell.toString()) ?? 0.0;
  }

  
  Map<String, int> _buildHeaderIndex(List<dynamic> headerRow) {
  final Map<String, int> indexMap = {};

  for (int i = 0; i < headerRow.length; i++) {
    final key = headerRow[i].toString().trim();
    indexMap[key] = i;
  }

  return indexMap;
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
                  child:FutureBuilder<List<StockKeepingModel>>(
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
                                  DataColumn(label: Text('Sku',style:TextStyle(fontWeight:FontWeight.bold))),
                                  DataColumn(label: Text('Category',style:TextStyle(fontWeight:FontWeight.bold))),
                                  DataColumn(label: Text('Unit Cost',style:TextStyle(fontWeight:FontWeight.bold))),
                                  DataColumn(label: Text('Min Stock Level',style:TextStyle(fontWeight:FontWeight.bold))),
                                  DataColumn(label: Text('Max Stock Level',style:TextStyle(fontWeight:FontWeight.bold))),
                                  DataColumn(label: Text('UOM',style:TextStyle(fontWeight:FontWeight.bold))),
                                  DataColumn(label: Text('Quantity',style:TextStyle(fontWeight:FontWeight.bold))),
                                  DataColumn(label: Text('Created By',style:TextStyle(fontWeight:FontWeight.bold))),
                                ],
                                rows: stockItems.map((item) {
                                  return DataRow(cells: [
                                    DataCell(Text(item.itemCode)),
                                    DataCell(Text(item.itemDescription)),
                                    DataCell(Text(item.sku)),
                                    DataCell(Text(item.category)),
                                    DataCell(Text(item.unitCost.toStringAsFixed(2))),
                                    DataCell(Text(item.minStockLevel.toStringAsFixed(1))),
                                    DataCell(Text(item.maxStockLevel.toStringAsFixed(1))),
                                    DataCell(Text(item.unitOfMeasurement)),
                                    DataCell(Text(item.quantity.toStringAsFixed(1))),
                                    DataCell(Text(item.createdBy)),
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