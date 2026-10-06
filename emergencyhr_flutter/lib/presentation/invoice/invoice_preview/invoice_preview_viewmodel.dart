import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/params/create_invoice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';

class InvoicePreviewViewModel extends BaseViewModel {
  final Invoice invoice;
  final GlobalKey previewKey = GlobalKey();

  bool _isGeneratingPdf = false;
  bool _isCapturingImage = false;

  bool get isGeneratingPdf => _isGeneratingPdf;
  bool get isCapturingImage => _isCapturingImage;

  InvoicePreviewViewModel(this.invoice);

  Future<void> generatePdf() async {
    _isGeneratingPdf = true;
    notifyListeners();

    try {
      final pdf = pw.Document();

      // Load Unicode font (Inter) to support the Nigerian Naira symbol "₦"
      final fontRegularData = await rootBundle.load(
        'assets/fonts/Inter-Regular.ttf',
      );
      final fontBoldData = await rootBundle.load('assets/fonts/Inter-Bold.ttf');
      final ttfRegular = pw.Font.ttf(fontRegularData);
      final ttfBold = pw.Font.ttf(fontBoldData);

      final pdfTheme = pw.ThemeData.withFont(
        base: ttfRegular,
        bold: ttfBold,
      );

      // Load logo image safely from asset bundle
      final logoBytes = (await rootBundle.load(
        'assets/pngs/bglow_logo.png',
      )).buffer.asUint8List();
      final logoImage = pw.MemoryImage(logoBytes);

      pdf.addPage(
        pw.Page(
          theme: pdfTheme,
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return _buildPdfContent(logoImage);
          },
        ),
      );

      // Save to device
      final output = await getApplicationDocumentsDirectory();
      final file = File(
        '${output.path}/invoice_${invoice.id.substring(0, 8)}.pdf',
      );
      await file.writeAsBytes(await pdf.save());

      // Share the PDF with iPad/iOS sharePositionOrigin support
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Invoice #${invoice.id.substring(0, 8)}',
        sharePositionOrigin: _getSharePositionOrigin(),
      );

      snackbarService.success(message: 'PDF generated and saved successfully!');
    } catch (e) {
      _showError('Failed to generate PDF: $e');
      debugPrint('Error generating PDF: $e');
    } finally {
      _isGeneratingPdf = false;
      notifyListeners();
    }
  }

  Future<void> captureAsImage() async {
    _isCapturingImage = true;
    notifyListeners();

    try {
      RenderRepaintBoundary boundary =
          previewKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save to device
      final output = await getApplicationDocumentsDirectory();
      final file = File(
        '${output.path}/invoice_${invoice.id.substring(0, 8)}.png',
      );
      await file.writeAsBytes(pngBytes);

      // Share the image with iPad/iOS sharePositionOrigin support
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Invoice #${invoice.id.substring(0, 8)}',
        sharePositionOrigin: _getSharePositionOrigin(),
      );

      snackbarService.success(
        message: 'Image captured and saved successfully!',
      );
    } catch (e) {
      _showError('Failed to capture image: $e');
      debugPrint('Error capturing image: $e');
    } finally {
      _isCapturingImage = false;
      notifyListeners();
    }
  }

  Rect _getSharePositionOrigin() {
    if (previewKey.currentContext != null) {
      final renderBox =
          previewKey.currentContext!.findRenderObject() as RenderBox?;
      if (renderBox != null && renderBox.hasSize) {
        final size = renderBox.size;
        final offset = renderBox.localToGlobal(Offset.zero);
        return Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);
      }
    }
    return const Rect.fromLTWH(0, 0, 300, 300);
  }

  pw.Widget _buildPdfContent(pw.MemoryImage logoImage) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Header
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'INVOICE',
                  style: pw.TextStyle(
                    fontSize: 32,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Invoice #: ${invoice.id.substring(0, 8).toUpperCase()}',
                ),
                pw.Text('Date: ${_formatDate(invoice.invoiceDate)}'),
                pw.Text('Due Date: ${_formatDate(invoice.dueDate)}'),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Image(
                  logoImage,
                  width: 100,
                  height: 100,
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Bglow creations ent.',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Shop 6, Fasogbon factory,\nAbegunde, Ibadan',
                  textAlign: pw.TextAlign.end,
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'No 26, Surulere Makun, Sagamu, Ogun state',
                  textAlign: pw.TextAlign.end,
                ),
                pw.SizedBox(height: 4),
                pw.Text('Phone: +2347067376069', textAlign: pw.TextAlign.end),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 30),

        // Customer Info
        pw.Container(
          padding: const pw.EdgeInsets.all(16),
          decoration: pw.BoxDecoration(border: pw.Border.all()),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Bill To:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                invoice.customerName,
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(invoice.customerAddress),
              pw.Text(invoice.customerPhone),
            ],
          ),
        ),
        pw.SizedBox(height: 30),

        // Items Table
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey400),
          columnWidths: const {
            0: pw.FlexColumnWidth(4),
            1: pw.FlexColumnWidth(1),
            2: pw.FlexColumnWidth(3),
            3: pw.FlexColumnWidth(3),
          },
          children: [
            // Header
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey300),
              children: [
                _buildPdfTableCell('Description', isHeader: true),
                _buildPdfTableCell(
                  'Qty',
                  isHeader: true,
                  align: pw.TextAlign.center,
                ),
                _buildPdfTableCell(
                  'Rate',
                  isHeader: true,
                  align: pw.TextAlign.right,
                ),
                _buildPdfTableCell(
                  'Total',
                  isHeader: true,
                  align: pw.TextAlign.right,
                ),
              ],
            ),
            // Items
            ...invoice.items.map(
              (item) => pw.TableRow(
                children: [
                  _buildPdfTableCell(item.name),
                  _buildPdfTableCell(
                    '${item.quantity}',
                    align: pw.TextAlign.center,
                  ),
                  _buildPdfTableCell(
                    CurrencyFormatter.formatNaira(item.price),
                    align: pw.TextAlign.right,
                  ),
                  _buildPdfTableCell(
                    CurrencyFormatter.formatNaira(item.total),
                    align: pw.TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 30),

        // Totals
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                  'Subtotal: ${CurrencyFormatter.formatNaira(invoice.subtotal)}',
                ),
                pw.Text(
                  invoice.taxRate > 0
                      ? 'Tax (${_formatTaxRate(invoice.taxRate)}%): ${CurrencyFormatter.formatNaira(invoice.tax)}'
                      : 'Tax: ${CurrencyFormatter.formatNaira(invoice.tax)}',
                ),
                pw.Divider(),
                pw.Text(
                  'Total: ${CurrencyFormatter.formatNaira(invoice.total)}',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 24),

        // Payment Details Box
        pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey400),
            color: PdfColors.grey100,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Payment Details',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              pw.SizedBox(height: 6),
              pw.Row(
                children: [
                  pw.Text(
                    'Bank: ',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  pw.Text(
                    appGlobals.user?.bankDetails?.bankName.isNotEmpty == true
                        ? appGlobals.user!.bankDetails!.bankName
                        : 'Moniepoint MFB',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ],
              ),
              pw.SizedBox(height: 3),
              pw.Row(
                children: [
                  pw.Text(
                    'Account Number: ',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  pw.Text(
                    appGlobals.user?.bankDetails?.accountNumber.isNotEmpty ==
                            true
                        ? appGlobals.user!.bankDetails!.accountNumber
                        : '7067376069',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 3),
              pw.Row(
                children: [
                  pw.Text(
                    'Account Name: ',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  pw.Text(
                    appGlobals.user?.bankDetails?.accountName.isNotEmpty == true
                        ? appGlobals.user!.bankDetails!.accountName
                        : 'Bglow creations ent.',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatTaxRate(double rate) {
    return rate % 1 == 0 ? rate.toInt().toString() : rate.toString();
  }

  pw.Widget _buildPdfTableCell(
    String text, {
    bool isHeader = false,
    pw.TextAlign align = pw.TextAlign.left,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: pw.Text(
        text,
        textAlign: align,
        style: pw.TextStyle(
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
          fontSize: 10,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showError(String message) {
    snackbarService.error(message: message);
  }
}
