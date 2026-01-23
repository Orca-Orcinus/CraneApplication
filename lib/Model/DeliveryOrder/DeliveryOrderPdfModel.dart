import "dart:typed_data";
import "package:craneapplication/Model/DeliveryOrder/DeliveryOrder.dart";
import "package:pdf/pdf.dart";
import "package:pdf/widgets.dart" as pw;

class DeliveryOrderPdfGenerator{
 static Future<Uint8List> generate(DeliveryOrder o) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(28, 24, 28, 24),
        build: (_) => [
          _companyHeader(o),
          pw.SizedBox(height: 10),
          _title(),
          pw.SizedBox(height: 12),
          _customerSection(o),
          pw.SizedBox(height: 16),
          _itemTable(o),
          pw.SizedBox(height: 12),
          _totalRow(o),
          pw.SizedBox(height: 50),
          _signatureSection(),
        ],
      ),
    );

    return pdf.save();
  }

  static pw.Widget _companyHeader(DeliveryOrder o) {
    return pw.Center(
      child:pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(o.companyName,
            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
        pw.Text(o.companyAddress, style: const pw.TextStyle(fontSize: 9)),
        pw.Text("Phone : ${o.companyPhone}        Email : ${o.companyEmail}",
            style: const pw.TextStyle(fontSize: 9)),
        ],
      )
    );

  }

  static pw.Widget _title() {
    return pw.Center(
      child: pw.Text(
        "DELIVERY ORDER",
        style: pw.TextStyle(
          fontSize: 16,
          fontWeight: pw.FontWeight.bold,
          decoration: pw.TextDecoration.underline,
        ),
      ),
    );
  }


  static pw.Widget _customerSection(DeliveryOrder o) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 3,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _info("CUSTOMER", o.customerName),
              _info("ADDRESS", o.deliveryAddress),
              _info("TEL", o.customerContact),
            ],
          ),
        ),
        pw.SizedBox(width: 18),
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _info("NO", o.doNumber),
              _info("DATE", _fmt(o.date)),              
              _info("TERMS", o.terms),
              _info("CURRENCY", o.currency),
              _info("AGENT", o.agentName),
              _info("AGENT TEL", o.agentPhone),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _info(String k, String v) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.Row(children: [
        pw.SizedBox(
            width: 72,
            child: pw.Text("$k :", style: const pw.TextStyle(fontSize: 9))),
        pw.Expanded(
            child: pw.Text(v, style: const pw.TextStyle(fontSize: 9))),
      ]),
    );
  }

  static String _fmt(DateTime d) =>
      "${d.day.toString().padLeft(2, '0')}/"
      "${d.month.toString().padLeft(2, '0')}/"
      "${d.year}";
  
  static pw.Widget _itemTable(DeliveryOrder order)
  {
    return pw.Table(
      border: pw.TableBorder.all(width: 0.8),
      columnWidths: {
        0: const pw.FixedColumnWidth(30),
        1: const pw.FlexColumnWidth(),
        2: const pw.FixedColumnWidth(50),
        3: const pw.FixedColumnWidth(60),
      },
      children: [
        _tableHeader(),
        ...order.items.map(_itemRow),
      ]
    );
  }

   static pw.TableRow _tableHeader() {
    return pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.grey300),
      children: [
        _th("NO"),
        _th("DESCRIPTION"),
        _th("UOM"),
        _th("QTY"),
      ],
    );
  }

   static pw.TableRow _itemRow(item) {
    return pw.TableRow(children: [
      _td(item.itemNumber.toString(), align: pw.TextAlign.center),
      _td(item.description),
      _td(item.uom, align: pw.TextAlign.center),
      _td(item.quantity.toStringAsFixed(2), align: pw.TextAlign.right),
    ]);
  }

  static pw.Widget _th(String t) => pw.Padding(
        padding: const pw.EdgeInsets.all(4),
        child: pw.Text(t,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
      );

  static pw.Widget _td(String t, {pw.TextAlign align = pw.TextAlign.left}) =>
      pw.Padding(
        padding: const pw.EdgeInsets.all(4),
        child: pw.Text(t,
            textAlign: align, style: const pw.TextStyle(fontSize: 9)),
      );

  static pw.Widget _totalRow(DeliveryOrder o) {
    return pw.Align(
      alignment: pw.Alignment.centerRight,
      child: pw.Container(
        width: 200,
        padding: const pw.EdgeInsets.only(top: 6),
        decoration: const pw.BoxDecoration(
          border: pw.Border(top: pw.BorderSide(width: 0.8)),
        ),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text("TOTAL",
                style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
            pw.Text(o.totalQty.toStringAsFixed(2),
                style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ],
        ),
      ),
    );
  }


  static pw.Widget _signatureSection() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(children: [
          pw.Text("AUTHORISED SIGNATURE", style: const pw.TextStyle(fontSize: 9)),
          pw.SizedBox(height: 30),
          pw.Container(width: 160, child: pw.Divider()),
        ]),
        pw.Column(children: [
          pw.Text("RECIPIENT'S CHOP & SIGNATURE",
              style: const pw.TextStyle(fontSize: 9)),
          pw.SizedBox(height: 30),
          pw.Container(width: 180, child: pw.Divider()),
        ]),
      ],
    );
  }
}