import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class InvoicePreviewScreen extends StatelessWidget {
  final File file;
  final int orderId;

  const InvoicePreviewScreen({
    super.key,
    required this.file,
    required this.orderId,
  });


  Future<File> saveInvoiceToDownloads(
      File sourceFile,
      int orderId,
      ) async {
    final directory = await getDownloadsDirectory();

    if (directory == null) {
      throw Exception('Downloads folder is unavailable');
    }

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    final destination = File(
      '${directory.path}/Invoice-$orderId.pdf',
    );

    await sourceFile.copy(destination.path);

    return destination;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F1F1),
      body:Column(

        children: [
          Stack(
            children: [
              AppBar(
                title: Text(
                  "Invoice#${orderId}",
                  style: TextStyle(
                    fontFamily: "poppins_bold",
                    color: Color(0xFFF6F1F1),
                  ),
                ),
                backgroundColor: Color(0xFFFE9D1D),
                leading: SizedBox(),
              ),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/food_doodle.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withValues(alpha: 0.4),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 16,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },

                  child: Icon(Icons.arrow_back_ios, color: Color(0xFFF6F1F1)),
                ),
              ),
            ],
          ),
          Expanded(
            child: PDFView(
              filePath: file.path,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              pageFling: true,
              minZoom: 1.0,
              maxZoom: 5.0,
              fitPolicy: FitPolicy.WIDTH,
              onError: (error) {
                debugPrint('PDF error: $error');
              },
            ),
          ),
          SizedBox(height: 10,),
          SizedBox(
            height: 50,
            width: 180,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Color(0xFF16171B),
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  await saveInvoiceToDownloads(file, orderId);
                  Fluttertoast.showToast(
                    msg: "Downloaded successfully.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black87,
                    textColor: Colors.white,
                    fontSize: 14.0,
                  );
                },
                child: Text(
                  "Download",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "poppins_semibold",
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}