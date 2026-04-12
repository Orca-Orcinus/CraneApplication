
import 'package:craneapplication/Model/ApplicationTool/pdfSaver.dart';
import 'package:craneapplication/Model/DeliveryOrder/DeliveryOrder.dart';
import 'package:craneapplication/Model/StockManagementModel/StockKeepingModel.dart';
import 'package:craneapplication/Model/UserProfile/CustomerProfile.dart';
import 'package:craneapplication/Model/WarehouseTool/StockKeepingItem.dart';
import 'package:craneapplication/components/MyDrawer.dart';
import 'package:flutter/material.dart';
import 'package:craneapplication/Model/DeliveryOrder/DeliveryOrderPdfModel.dart';
import 'package:dropdown_search/dropdown_search.dart';

class DeliveryOrderPage extends StatefulWidget {
  const DeliveryOrderPage({super.key});

  @override
  State<DeliveryOrderPage> createState() => _DeliveryOrderPageState();
}

class _DeliveryOrderPageState extends State<DeliveryOrderPage> {
  final _formKey = GlobalKey<FormState>();

  final _doNo = TextEditingController();
  final _agent = TextEditingController();
  final _agentPhone = TextEditingController();

  final _address = TextEditingController();
  final _terms = TextEditingController();
  final _currency = TextEditingController();
  final _customerPhone = TextEditingController();
  CustomerProfile? selectedCustomer;
  List<CustomerProfile> customers = [];
  bool _isLoadingCustomers = true;
  String? _customerLoadError;
  final List<DeliveryOrderItems> _items = [];
  List<StockKeepingModel> warehouseItems = [];

  @override 
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCustomer();
    _loadStockKeepingItems();
  }

  @override
  void dispose() {
    _doNo.dispose();
    _agent.dispose();
    _agentPhone.dispose();
    _address.dispose();
    _terms.dispose();
    _currency.dispose();
    _customerPhone.dispose();
    super.dispose();
  }

  
  Future<void> _loadCustomer() async {
    try {
      setState(() {
        _isLoadingCustomers = true;
        _customerLoadError = null;
      });

      final data = await CustomerDatabaseControl().fetchAllCustomers();

      setState(() {
        customers = data;
        _isLoadingCustomers = false;
      });
    } catch (e) {
      setState(() {
        _customerLoadError = e.toString();
        _isLoadingCustomers = false;
      });
    }
  }

  Future<void> _loadStockKeepingItems() async
  {
    final data = await StockKeepingItem().fetchAllWarehouseItem();

    setState(() {
      warehouseItems = data;
    });
  }

  void _addItem() {    
    StockKeepingModel? selectedItem;
    final desCtrl = TextEditingController();
    final uomCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context)
      {
        return AlertDialog(
          title: const Text("Add Item"),
          content: StatefulBuilder(
            builder:(context, setLocalState)
            {
              return SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownSearch<StockKeepingModel>(       
                      compareFn: (a,b) => a.itemCode == b.itemCode,               
                      items : (filter,_) => warehouseItems,
                      itemAsString: (s) => s.itemDescription,
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                      ),
                      decoratorProps: const DropDownDecoratorProps(
                        decoration: InputDecoration(
                          labelText: "Select Item",
                          border: OutlineInputBorder(),
                        ),
                      ),

                      onChanged: (item)
                      {
                        setLocalState(()
                        {
                          selectedItem = item;
                          desCtrl.text = item!.itemDescription;
                          uomCtrl.text = item.unitOfMeasurement ?? '';
                        });
                      },
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      controller: uomCtrl,
                      decoration: const InputDecoration(
                        labelText: "UOM",
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextFormField(
                      controller: qtyCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Quantity",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),                
              );
            },
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(
              child: const Text("Add"),
              onPressed: ()
              {
                final qty = double.tryParse(qtyCtrl.text);
                if(desCtrl.text.isEmpty || uomCtrl.text.isEmpty || qty == null)
                {
                  // show error
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill in all fields with valid data"))
                  );
                  return;
                }
                setState(() {
                  _items.add(DeliveryOrderItems(
                    itemNumber: _items.length + 1, 
                    description: selectedItem!.itemDescription, 
                    uom: uomCtrl.text, 
                    quantity: qty));
                });
                Navigator.pop(context);
              },              
            ),
          ],
        );         
      },
    );
  }

  void _removeItem(int i) {
    setState(() {
      _items.removeAt(i);
      for (int x = 0; x < _items.length; x++) {
        _items[x] = DeliveryOrderItems(
          itemNumber: x + 1,
          description: _items[x].description,
          uom: _items[x].uom,
          quantity: _items[x].quantity,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Delivery Order")),
      drawer: MyDrawer(),
      body: _isLoadingCustomers
          ? const Center(child: CircularProgressIndicator())

          : _customerLoadError != null
              ? _errorView()

              : Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _doHeaderSection(),
                      const SizedBox(height: 16),
                      _itemHeader(),
                      _itemTable(),
                      const SizedBox(height: 12),
                      _addItemButton(),
                      const Divider(height: 30),
                      _totalBar(),
                      const SizedBox(height: 20),
                      _generateButton(),
                    ],
                  ),
                ),
    );
  }

  Widget _errorView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.cloud_off, size: 48, color: Colors.red),
          const SizedBox(height: 12),
          const Text(
            "Failed to load customers",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            _customerLoadError ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text("Retry"),
            onPressed: _loadCustomer,
          )
        ],
      ),
    );
  }
  
  Widget _doHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(child: _textField("DO Number", _doNo)),
          const SizedBox(width: 10),
          Expanded(child: _customerDropdown()),
        ]),
        const SizedBox(height: 10),
        _readOnlyField("Customer Address", _address, maxLines: 2),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(child: _readOnlyField("Customer Phone", _customerPhone)),
          const SizedBox(width: 10),
          Expanded(child: _readOnlyField("Terms", _terms)),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(child: _readOnlyField("Currency", _currency)),
          const SizedBox(width: 10),
          Expanded(child: _textField("Agent Name", _agent)),
        ]),
        const SizedBox(height: 8),
        _textField("Agent Phone", _agentPhone),
      ],
    );
  }


  Widget _customerDropdown() {
    return DropdownSearch<CustomerProfile>(
      items: (filter, _) async {
        // local list (already loaded from Firebase)
        if (filter.isEmpty) return customers;
        return customers
            .where((c) =>
                c.customerName.toLowerCase().contains(filter.toLowerCase()))
            .toList();
      },

      selectedItem: selectedCustomer,

      itemAsString: (c) => c.customerName,

      compareFn: (a, b) => a.customerId == b.customerId,
      // IMPORTANT: use your unique id field

      popupProps: const PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: "Search customer...",
            border: OutlineInputBorder(),
          ),
        ),
      ),

      decoratorProps: const DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: "Customer",
          border: OutlineInputBorder(),
        ),
      ),

      validator: (v) => v == null ? "Select a customer" : null,

      onChanged: (c) {
        setState(() {
          selectedCustomer = c;
          _address.text = c?.customerAddress ?? '';
          _customerPhone.text = c?.customerPhoneNumber ?? '';
          _terms.text = "C.O.D";
          _currency.text = "RM";
        });
      },
    );
  }

  Widget _textField(String label, TextEditingController c,
      {int maxLines = 1}) {
    return TextFormField(
      controller: c,
      maxLines: maxLines,
      decoration:
          InputDecoration(labelText: label, border: const OutlineInputBorder()),
      validator: (v) => v == null || v.isEmpty ? "Required" : null,
    );
  }

  Widget _readOnlyField(String label, TextEditingController c,
      {int maxLines = 1}) {
    return TextFormField(
      controller: c,
      maxLines: maxLines,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        fillColor: Colors.grey.shade100,
        filled: true,
      ),
    );
  }

  Widget _itemHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      color: Colors.grey.shade300,
      child: Row(children: const [
        _HCell("NO", 40),
        _HCell("DESCRIPTION", 1000),
        _HCell("UOM", 70),
        _HCell("QTY", 80),
        SizedBox(width: 40),
      ]),
    );
  }

  Widget _itemTable() {
    return Column(
      children: List.generate(_items.length, (i) {
        final item = _items[i];
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          child: Row(children: [
            _cell(Text(item.itemNumber.toString()), 40),
            _cell(Text(item.description),1000),
            _cell(Text(item.uom), 70),
            _cell(Text(item.quantity.toString()), 80),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removeItem(i),
            )
          ]),
        );
      }),
    );
  }



  Widget _addItemButton()
  {
    return Align(
      alignment: Alignment.centerLeft,
      child: ElevatedButton.icon(
        onPressed: _addItem,
        icon: const Icon(Icons.add),
        label: const Text("Add Item"),
      ),
    );
  }
  
  Widget _totalBar() {
    double total = 0;
    for(int x = 0; x <_items.length; x++)
    {
      total += _items[x].quantity;
    }
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        "TOTAL QTY: ${total.toStringAsFixed(2)}",
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _generateButton()
  {
    return SizedBox(
      height:48,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.picture_as_pdf),
        onPressed: _generatePdf, 
        label: const Text("Generate Delivery Order")),
    );
  }

  Future<void> _generatePdf() async {
    try{
      if (!_formKey.currentState!.validate()) return;

        final order = DeliveryOrder(
          doNumber: _doNo.text,
          date: DateTime.now(),

          // from customer DB
          customerName: selectedCustomer!.customerName,
          deliveryAddress: _address.text,
          customerContact: _customerPhone.text,
          terms: _terms.text,

          // from UI
          agentName: _agent.text,
          agentPhone: _agentPhone.text,

          items: List.from(_items),
        );

        final bytes = await DeliveryOrderPdfGenerator.generate(order);
        await PdfSaver.savePdf(
          bytes,
          "DeliveryOrder_${order.doNumber}.pdf",
        );
    // Printing.layoutPdf(onLayout: (_) async => bytes);
    }
    catch(e)
    {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error generating PDF: $e"))
      );
    }
 
  }


  Widget _cell(Widget child, [double? width]) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(6),
      child: child,
    );
  }  

  Widget _numberField(double v, Function(double) onChanged) {
    return TextFormField(
      initialValue: v == 0 ? '' : v.toString(),
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(border: InputBorder.none),
      onChanged: (t) =>
          onChanged(double.tryParse(t) ?? 0),
    );
  }
}

class _HCell extends StatelessWidget {
  final String text;
  final double? width;
  const _HCell(this.text, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(6),
      child: Text(text,
          style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}