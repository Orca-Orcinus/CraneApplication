import 'dart:io';

import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

import '../Model/StockManagementModel/GroupItemModel.dart';
import '../components/MyDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Model/WarehouseTool/GroupItem.dart';
import 'package:flutter/material.dart';


class GroupItemPage extends StatefulWidget {
  const GroupItemPage({super.key});

  @override
  State<GroupItemPage> createState() => _GroupItemPageState();
}

class _GroupItemPageState extends State<GroupItemPage> {
  final GroupItemController _groupItemController = GroupItemController();
  String _selectedFilter = 'All';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
  }

  Future<List<GroupItemModel>> _fetchFilteredGroupItems() async {
    List<GroupItemModel> groupItems;

    switch (_selectedFilter) {
      case 'All':
        groupItems = await _groupItemController.fetchAllGroupItems();
        break;
      default:
        groupItems = await _groupItemController.fetchAllGroupItems();
    }

    if(_searchQuery.isNotEmpty) {
      groupItems = groupItems.where((item) =>
          item.itemDescription.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.itemCode.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }

    return groupItems;
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

  void _showEditDialog(BuildContext context, GroupItemModel item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Group Item'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: TextEditingController(text: item.itemDescription),
                  decoration: const InputDecoration(labelText: 'Item Description'),
                  onChanged: (value) {
                    item.itemDescription = value;
                  },
                ),
                TextField(
                  controller: TextEditingController(text: item.salesCode),
                  decoration: const InputDecoration(labelText: 'Sales Code'),
                  onChanged: (value) {
                    item.salesCode = value;
                  },
                ),                
                TextField(
                  controller: TextEditingController(text: item.cashSalesCode),
                  decoration: const InputDecoration(labelText: 'Cash Sales Code'),
                  onChanged: (value) {
                    item.cashSalesCode = value;
                  },
                ),                
                TextField(
                  controller: TextEditingController(text: item.salesReturnCode),
                  decoration: const InputDecoration(labelText: 'Sales Return Code'),
                  onChanged: (value) {
                    item.salesReturnCode = value;
                  },
                ),                
                TextField(
                  controller: TextEditingController(text: item.purchaseCode),
                  decoration: const InputDecoration(labelText: 'Purchase Code'),
                  onChanged: (value) {
                    item.purchaseCode = value;
                  },
                ),                
                TextField(
                  controller: TextEditingController(text: item.cashPurchaseCode),
                  decoration: const InputDecoration(labelText: 'Cash Purchase Code'),
                  onChanged: (value) {
                    item.cashPurchaseCode = value;
                  },
                ),                
                TextField(
                  controller: TextEditingController(text: item.purchaseReturnCode),
                  decoration: const InputDecoration(labelText: 'Purchase Return Code'),
                  onChanged: (value) {
                    item.purchaseReturnCode = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try{
                  final updatedItem = GroupItemModel(
                    itemCode: item.itemCode,
                    itemDescription: item.itemDescription,
                    salesCode: item.salesCode,
                    cashSalesCode: item.cashSalesCode,
                    salesReturnCode: item.salesReturnCode,
                    purchaseCode: item.purchaseCode,
                    cashPurchaseCode: item.cashPurchaseCode,
                    purchaseReturnCode: item.purchaseReturnCode,
                  );
                  await _groupItemController.updateGroupItem(item);
                  if(mounted)
                  {
                    Navigator.of(context).pop();
                    setState(() {                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Group item updated successfully')),
                      );
                    });
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error updating group item: $e')),
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

  void _showItemDetails(BuildContext context, GroupItemModel item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Group Item: ${item.itemCode}'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Item Description', item.itemDescription),
                _buildDetailRow('Sales Code', item.salesCode),
                _buildDetailRow('Cash Sales Code', item.cashSalesCode),
                _buildDetailRow('Sales Return Code', item.salesReturnCode),
                _buildDetailRow('Purchase Code', item.purchaseCode),
                _buildDetailRow('Cash Purchase Code', item.cashPurchaseCode),
                _buildDetailRow('Purchase Return Code', item.purchaseReturnCode),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Confirm Deletion'),
                      content: const Text('Are you sure you want to delete this group item?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
                if (confirm == true)
                {
                   try{
                    await _groupItemController.deleteGroupItem(item);
                    if(mounted)
                    {
                      Navigator.of(context).pop();
                      setState(() {                    
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Group item deleted successfully')),
                        );
                      });
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error deleting group item: $e')),
                      );
                  }
                }             
            },
              child: const Text("Delete",style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showEditDialog(context, item);
              },
              child: const Text('Edit'),
            ),
          ],
        );
      },
    );
  }

  void _showAddItemDialog(BuildContext context) {
    final _itemCodeController = TextEditingController();
    final _itemDescriptionController = TextEditingController();
    final _itemSalesCode = TextEditingController();
    final _itemCashSalesCode = TextEditingController();
    final _itemSalesReturnCode = TextEditingController();
    final _itemPurchaseCode = TextEditingController();
    final _itemCashPurchaseCode = TextEditingController();
    final _itemPurchaseReturnCode = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Group Item'),
          content: SingleChildScrollView(
            child:Column(
              children: [
                TextField(
                  controller: _itemCodeController,
                  decoration: const InputDecoration(labelText: 'Item Code'),
                ),
                TextField(
                  controller: _itemDescriptionController,
                  decoration: const InputDecoration(labelText: 'Item Description'),
                ),
                TextField(
                  controller: _itemSalesCode,
                  decoration: const InputDecoration(labelText: 'Sales Code'),
                ),                
                TextField(
                  controller: _itemCashSalesCode,
                  decoration: const InputDecoration(labelText: 'Cash Sales Code'),
                ),                
                TextField(
                  controller: _itemSalesReturnCode,
                  decoration: const InputDecoration(labelText: 'Sales Return Code'),
                ),                
                TextField(
                  controller: _itemPurchaseCode,
                  decoration: const InputDecoration(labelText: 'Purchase Code'),
                ),                
                TextField(
                  controller: _itemCashPurchaseCode,
                  decoration: const InputDecoration(labelText: 'Cash Purchase Code'),
                ),                
                TextField(
                  controller: _itemPurchaseReturnCode,
                  decoration: const InputDecoration(labelText: 'Purchase Return Code'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try{
                  final newItem = GroupItemModel(
                    itemCode: _itemCodeController.text,
                    itemDescription: _itemDescriptionController.text,
                    salesCode: _itemSalesCode.text,
                    cashSalesCode: _itemCashSalesCode.text,
                    salesReturnCode: _itemSalesReturnCode.text,
                    purchaseCode: _itemPurchaseCode.text,
                    cashPurchaseCode: _itemCashPurchaseCode.text,
                    purchaseReturnCode: _itemPurchaseReturnCode.text,
                  );
                  await _groupItemController.createGroupItem(newItem);
                  if(mounted)
                  {
                    Navigator.of(context).pop();
                    setState(() {                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Group item added successfully')),
                      );
                    });
                  }
                }
                catch(e)
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error adding group item: $e')),
                  );
                }
              },
              child: const Text('Add'),
            ),
            ElevatedButton(
              onPressed: () async
              {
                _importFromFile(context);
              },
              child: const Text("Import Data")
              )
          ],
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

        if(sheet != null)
        {
          for(final row in sheet.rows)
          {
            parsedRows.add(row.map((cell) => cell?.value).toList());
          }
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
          final newItem = new GroupItemModel(
            itemCode: parsedRows[headers[0]!].toString(), 
            itemDescription: parsedRows[headers[2]!].toString(),
            salesCode: parsedRows[headers[4]!].toString(),
            salesReturnCode: parsedRows[headers[5]!].toString(),
            cashSalesCode: parsedRows[headers[7]!].toString(), 
            purchaseCode: parsedRows[headers[8]!].toString(),
            purchaseReturnCode: parsedRows[headers[10]!].toString(), 
            cashPurchaseCode: parsedRows[headers[11]!].toString(),
            );

            await _groupItemController.createGroupItem(newItem);
        } catch (e) {
          if(!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Import failed for $e")));
        }
      }

    } catch (e) {
      if(!mounted)
        return;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Items'),
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddItemDialog(context);                    
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Item'),
      ),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context,snapshot)
        {
          if(snapshot.hasData)
          {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterButton('All', 'All'),
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<GroupItemModel>>(
                    future: _fetchFilteredGroupItems(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No group items found.'));
                      } else {
                        final groupItems = snapshot.data!;
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await _fetchFilteredGroupItems();
                            },
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: DataTable(
                                columns: const [
                                  DataColumn(label: Text('Item Code')),
                                  DataColumn(label: Text('Item Description')),
                                  DataColumn(label: Text('Sales Code')),
                                  DataColumn(label: Text('Cash Sales Code')),
                                  DataColumn(label: Text('Sales Return Code')),
                                  DataColumn(label: Text('Purchase Code')),
                                  DataColumn(label: Text('Cash Purchase Code')),
                                  DataColumn(label: Text('Purchase Return Code')),
                                ],
                                rows: groupItems.map((item) {
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(item.itemCode)),
                                      DataCell(Text(item.itemDescription)),
                                      DataCell(Text(item.salesCode)),
                                      DataCell(Text(item.cashSalesCode)),
                                      DataCell(Text(item.salesReturnCode)),
                                      DataCell(Text(item.purchaseCode)),
                                      DataCell(Text(item.cashPurchaseCode)),
                                      DataCell(Text(item.purchaseReturnCode)),
                                    ],
                                    onSelectChanged: (selected) {
                                      if (selected == true) {
                                        _showItemDetails(context, item);
                                      }
                                    },
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
            return const Center(child: Text('Please log in to view group items.'));
          }
        },
      ),
    );
  }
}