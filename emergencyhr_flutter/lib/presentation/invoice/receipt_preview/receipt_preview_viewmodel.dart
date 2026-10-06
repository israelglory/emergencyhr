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

class ReceiptPreviewViewModel extends BaseViewModel {
  final PaymentReceipt receipt;
  final GlobalKey previewKey = GlobalKey();

  bool _isGeneratingPdf = false;
  bool _isCapturingImage = false;

  bool get isGeneratingPdf => _isGeneratingPdf;
  bool get isCapturingImage => _isCapturingImage;

  ReceiptPreviewViewModel(this.receipt);

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
      final sanitizedReceiptNo = receipt.receiptNumber.replaceAll(
        RegExp(r'[^a-zA-Z0-9_-]'),
        '_',
      );
      final file = File('${output.path}/receipt_$sanitizedReceiptNo.pdf');
      await file.writeAsBytes(await pdf.save());

      // Share the PDF
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Receipt #${receipt.receiptNumber} (${receipt.invoiceNumber})',
        sharePositionOrigin: _getSharePositionOrigin(),
      );

      snackbarService.success(message: 'PDF generated and saved successfully!');
    } catch (e) {
      _showError('Failed to generate PDF: $e');
      debugPrint('Error generating Receipt PDF: $e');
    } finally {
      _isGeneratingPdf = false;
      notifyListeners();
    }
  }

  Future<void> captureAsImage() async {
    _isCapturingImage = true;
    notifyListeners();

    try {
      final boundary =
          previewKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save to device
      final output = await getApplicationDocumentsDirectory();
      final sanitizedReceiptNo = receipt.receiptNumber.replaceAll(
        RegExp(r'[^a-zA-Z0-9_-]'),
        '_',
      );
      final file = File('${output.path}/receipt_$sanitizedReceiptNo.png');
      await file.writeAsBytes(pngBytes);

      // Share the image
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Receipt #${receipt.receiptNumber} (${receipt.invoiceNumber})',
        sharePositionOrigin: _getSharePositionOrigin(),
      );

      snackbarService.success(
        message: 'Image captured and saved successfully!',
      );
    } catch (e) {
      _showError('Failed to capture image: $e');
      debugPrint('Error capturing Receipt image: $e');
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
    final isFullyPaid = receipt.remainingBalance <= 0.0001;

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
                  'PAYMENT RECEIPT',
                  style: pw.TextStyle(
                    fontSize: 26,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'Receipt #: ${receipt.receiptNumber}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.Text('Invoice #: ${receipt.invoiceNumber}'),
                pw.Text('Payment Date: ${_formatDate(receipt.paymentDate)}'),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Image(
                  logoImage,
                  width: 90,
                  height: 90,
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Bglow creations ent.',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                pw.SizedBox(height: 3),
                pw.Text(
                  'Shop 6, Fasogbon factory,\nAbegunde, Ibadan',
                  textAlign: pw.TextAlign.end,
                ),
                pw.SizedBox(height: 3),
                pw.Text(
                  'No 26, Surulere Makun, Sagamu, Ogun state',
                  textAlign: pw.TextAlign.end,
                ),
                pw.SizedBox(height: 3),
                pw.Text('Phone: +2347067376069', textAlign: pw.TextAlign.end),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 24),

        // Received From
        pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey400),
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Received From:',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 11,
                ),
              ),
              pw.SizedBox(height: 6),
              pw.Text(
                receipt.customerName,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              if (receipt.customerAddress.isNotEmpty)
                pw.Text(receipt.customerAddress),
              if (receipt.customerPhone.isNotEmpty)
                pw.Text(receipt.customerPhone),
            ],
          ),
        ),
        pw.SizedBox(height: 24),

        // Payment Summary Table
        pw.Container(
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey400),
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
          ),
          child: pw.Column(
            children: [
              _buildPdfSummaryRow(
                'Invoice Total',
                CurrencyFormatter.formatNaira(receipt.invoiceTotal),
              ),
              _buildPdfSummaryRow(
                'Previous Amount Paid',
                CurrencyFormatter.formatNaira(receipt.previousAmountPaid),
              ),
              _buildPdfSummaryRow(
                'Amount Paid (This Payment)',
                CurrencyFormatter.formatNaira(receipt.amount),
                isHighlighted: true,
              ),
              _buildPdfSummaryRow('Payment Method', receipt.paymentMethod),
              _buildPdfSummaryRow(
                'Total Amount Paid to Date',
                CurrencyFormatter.formatNaira(receipt.totalAmountPaid),
              ),
              _buildPdfSummaryRow(
                'Remaining Balance',
                CurrencyFormatter.formatNaira(receipt.remainingBalance),
                isHighlighted: true,
                isTotal: true,
              ),
              _buildPdfSummaryRow(
                'Payment Status',
                isFullyPaid ? 'FULLY PAID' : 'PARTIALLY PAID',
              ),
            ],
          ),
        ),

        if (receipt.note != null && receipt.note!.trim().isNotEmpty) ...[
          pw.SizedBox(height: 16),
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              color: PdfColors.grey100,
              border: pw.Border.all(color: PdfColors.grey300),
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Note / Reference:',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
                pw.SizedBox(height: 3),
                pw.Text(receipt.note!, style: const pw.TextStyle(fontSize: 10)),
              ],
            ),
          ),
        ],

        pw.SizedBox(height: 24),

        // Bank / Payment Details
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
                  fontSize: 11,
                ),
              ),
              pw.SizedBox(height: 5),
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
              pw.SizedBox(height: 2),
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
              pw.SizedBox(height: 2),
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

        pw.SizedBox(height: 24),
        pw.Center(
          child: pw.Text(
            'Thank you for your business!',
            style: pw.TextStyle(
              fontStyle: pw.FontStyle.italic,
              color: PdfColors.grey700,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _buildPdfSummaryRow(
    String label,
    String value, {
    bool isHighlighted = false,
    bool isTotal = false,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: pw.BoxDecoration(
        color: isHighlighted ? PdfColors.grey200 : PdfColors.white,
        border: const pw.Border(
          bottom: pw.BorderSide(color: PdfColors.grey300, width: 0.5),
        ),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontWeight: isTotal || isHighlighted
                  ? pw.FontWeight.bold
                  : pw.FontWeight.normal,
              fontSize: 11,
            ),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontWeight: isTotal || isHighlighted
                  ? pw.FontWeight.bold
                  : pw.FontWeight.normal,
              fontSize: isTotal ? 13 : 11,
            ),
          ),
        ],
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
