import 'dart:io';

import 'package:craneapplication/Model/StockManagementModel/StockItemModel.dart';
import 'package:craneapplication/Model/WarehouseTool/GroupItem.dart';
import 'package:craneapplication/Model/WarehouseTool/StockItem.dart';
import 'package:craneapplication/components/MyDrawer.dart';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StockDataPage extends StatefulWidget {
  const StockDataPage({super.key});

  @override
  State<StockDataPage> createState() => _StockDataState();
}

class _StockDataState extends State<StockDataPage> {
  final StockItemController _stockItemController = StockItemController();
  final GroupItemController _groupItemController = GroupItemController();

  String _selectedFilter = 'all'; // all, in_stock, out_of_stock
  String _searchQuery = ''; //itemGroup search query

  @override
  void initState() {
    super.initState();
  }  

  Future<List<StockItemModel>> _fetchFilteredStockItems() async {
    // Implement filtering logic based on _selectedFilter and _searchQuery
    List<StockItemModel> allItems;

    switch(_selectedFilter) {
      case 'all':
      default:
        // Fetch all items
        allItems = await _stockItemController.fetchAllStockItems();
        break;
    }

    if(_searchQuery.isNotEmpty)
    {
      final q = _searchQuery.toLowerCase();
      allItems = allItems.where((item) => item.itemGroup.toLowerCase().contains(q)).toList();
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

  void _showEditDialog(BuildContext context,StockItemModel item)
  {
    final descriptionController = TextEditingController(text: item.itemDescription);
    final uomController = TextEditingController(text: item.unitOfMeasurement);
    final purchaseCostController = TextEditingController(text: item.purchaseCost.toString());
    final salesPriceController = TextEditingController(text: item.salesPrice.toString());
    
    String? selectedItemGroup;

    showDialog(
      context: context,
      builder: (BuildContext context)
      {
        return FutureBuilder<List<String>>(
          future: fetchItemGroups(), 
          builder: (context,snapshot)
          {
            if(snapshot.connectionState == ConnectionState.waiting)
            {
              return const AlertDialog(content: SizedBox(height: 100,child: Center(child: CircularProgressIndicator()),),);
            }
            if(snapshot.hasError)
            {
              return AlertDialog(
                content: Text("Failed to load item groups"),
                actions: [
                  TextButton(onPressed: ()=> Navigator.pop(context),child: const Text("Close"),)
                ],
              );
            }

            final itemGroups = snapshot.data!;

            return StatefulBuilder(builder: (context,setDialogState)
            {
              return AlertDialog(
                title: const Text("Edit Stock Item"),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(labelText: "Item Description"),
                      ),
                      DropdownButtonFormField<String>(
                        value: selectedItemGroup,
                        decoration: const InputDecoration(labelText: "Item Group"),
                        items:itemGroups.
                          map(
                            (group) => DropdownMenuItem(
                              child: Text(group),
                              value:group),
                              ).toList(),
                            onChanged: (value) {
                              setDialogState(()=> selectedItemGroup = value);
                            },
                        ),        
                      TextField(
                        controller: uomController,
                        decoration: const InputDecoration(labelText: "Unit of Measurement"),
                      ),
                      TextField(
                        controller: purchaseCostController,
                        decoration: const InputDecoration(labelText: "Purchase Cost"),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: salesPriceController,
                        decoration: const InputDecoration(labelText: "Sales Price"),
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
                      if(selectedItemGroup == null)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select an item group")));
                        return;
                      }

                      try{
                        final updatedItem = StockItemModel(
                          itemCode: item.itemCode,
                          itemDescription: descriptionController.text,
                          itemGroup: selectedItemGroup!,
                          unitOfMeasurement: uomController.text,
                          purchaseCost: double.tryParse(purchaseCostController.text) ?? 0.0,
                          salesPrice: double.tryParse(salesPriceController.text) ?? 0.0,
                        );
                        await _stockItemController.updateStockItem(updatedItem);
                        if(mounted)
                        {
                          Navigator.of(context).pop();
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Stock item updated successfully")),
                            );
                          });
                        }
                      }
                      catch (e)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error updating stock item: $e")),
                        );
                      }            
                    },
                    child: const Text("Save"),
                  ),
                ],
              );
            });
          }
        );     
      },
    );
  }
  
  Future<void> _importFromFile(BuildContext context) async
  {
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

        final headers = _buildHeaderIndex(parsedRows.first);

        for(int i = 1; i < parsedRows.length;i++)
        {
          final row = parsedRows[i];        

          try {
            final newItem = StockItemModel(
              itemCode: parsedRows[headers[0]!].toString(), 
              itemDescription: parsedRows[headers[2]!].toString(),
              itemGroup: parsedRows[headers[3]!].toString(),
              unitOfMeasurement: parsedRows[headers[4]!].toString(),
              purchaseCost: double.tryParse(parsedRows[headers[5]!].toString()) ?? 0.0,
              salesPrice: double.tryParse([headers[6]!].toString()) ?? 0.0,
              );

              await _stockItemController.createStockItem(newItem);
          } catch (e) {
            if(!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Import failed for $e")));
          }
        }

      } catch (e) {
        if(!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to import CSV:$e")));
      }
    }

    Map<String, int> _buildHeaderIndex(List<dynamic> headerRow) {
    final Map<String, int> indexMap = {};

    for (int i = 0; i < headerRow.length; i++) {
      final key = headerRow[i].toString().trim();
      indexMap[key] = i;
    }

    return indexMap;
  }

  void _showItemDetails(BuildContext context, StockItemModel item) {
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
                _buildDetailRow("Item Group", item.itemGroup),
                _buildDetailRow("Unit of Measurement", item.unitOfMeasurement),
                _buildDetailRow("Purchase Cost", item.purchaseCost.toStringAsFixed(2)),
                _buildDetailRow("Sales Price", item.salesPrice.toStringAsFixed(2)),
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
                      content: const Text("Are you sure you want to delete this stock item?"),
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
                    await _stockItemController.deleteStockItem(item);
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

  Future<List<String>> fetchItemGroups() async 
  {
    final snapshot = await _groupItemController.fetchAllGroupItemNames();

    return snapshot;
  }

  void _showAddItemDialog(BuildContext context) {
    final itemCodeController = TextEditingController();
    final itemDescriptionController = TextEditingController();
    final uomController = TextEditingController();
    final purchaseCostController = TextEditingController();
    final salesPriceController = TextEditingController();

    String? selectedItemGroup;

    showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder<List<String>>(
          future: fetchItemGroups(), 
          builder: (context,snapshot)
          {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const AlertDialog(content:SizedBox(height: 100, child: Center(child:CircularProgressIndicator())));
            }

            if(snapshot.hasError)
            {
              return AlertDialog(
                content: Text("Failed to load item groups"),
                actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close"))],
                );
            }

            final itemGroups = snapshot.data!;

            return StatefulBuilder(
              builder: (context,setDialogState){
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
                          controller: itemDescriptionController,
                          decoration: const InputDecoration(labelText: "Item Description"),
                        ),
                        DropdownButtonFormField<String>(
                          value: selectedItemGroup,
                          decoration: const InputDecoration(labelText: "Item Group"),
                          items: itemGroups
                            .map(
                              (group) => DropdownMenuItem(
                                value: group,
                                child: Text(group),
                              ),
                            )
                            .toList(),
                            onChanged: (value){
                              setDialogState((){
                                selectedItemGroup = value;
                              });
                            },
                        ),
                        TextField(
                          controller: uomController,
                          decoration: const InputDecoration(labelText: "Unit of Measurement"),
                        ),
                        TextField(
                          controller: purchaseCostController,
                          decoration: const InputDecoration(labelText: "Purchase Cost"),
                          keyboardType: TextInputType.number,
                        ),
                        TextField(
                          controller: salesPriceController,
                          decoration: const InputDecoration(labelText: "Sales Price"),
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
                        if(selectedItemGroup == null)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select an item group.")));
                          return;
                        }
                        try{
                          final newItem = StockItemModel(
                            itemCode: itemCodeController.text,
                            itemDescription: itemDescriptionController.text,
                            itemGroup: selectedItemGroup!,
                            unitOfMeasurement: uomController.text,
                            purchaseCost: double.tryParse(purchaseCostController.text) ?? 0.0,
                            salesPrice: double.tryParse(salesPriceController.text) ?? 0.0,
                          );
                          await _stockItemController.createStockItem(newItem);
                          if(mounted)
                          {
                            Navigator.of(context).pop();
                            setState(() {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Stock item added successfully")),
                              );
                            });
                          }
                        }
                        catch (e)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error adding stock item: $e")),
                          );
                        }            
                      },
                      child: const Text("Add"),
                    ),
                  ],
                );
              });
          });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Stock Data"),
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()  => _showAddItemDialog(context),
        icon: const Icon(Icons.add),
        label: const Text("Add Stock Item"),
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
                        hintText: "Search by Item Group",
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
                  child:FutureBuilder<List<StockItemModel>>(
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
                                  DataColumn(label: Text('Item Group',style:TextStyle(fontWeight:FontWeight.bold))),
                                  DataColumn(label: Text('UOM',style:TextStyle(fontWeight:FontWeight.bold))),
                                  DataColumn(label: Text('Purchase Cost',style:TextStyle(fontWeight:FontWeight.bold))),
                                  DataColumn(label: Text('Sales Price',style:TextStyle(fontWeight:FontWeight.bold))),
                                ],
                                rows: stockItems.map((item) {
                                  return DataRow(cells: [
                                    DataCell(Text(item.itemCode)),
                                    DataCell(Text(item.itemDescription)),
                                    DataCell(Text(item.itemGroup)),
                                    DataCell(Text(item.unitOfMeasurement)),
                                    DataCell(Text(item.purchaseCost.toStringAsFixed(2))),
                                    DataCell(Text(item.salesPrice.toStringAsFixed(2))),
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