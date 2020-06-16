import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:glow/data/book.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/providers/student_provider/student_file_provider.dart';
import 'package:provider/provider.dart';

class StudentBookReader extends StatefulWidget {
  final Book book;
  StudentBookReader(this.book);
  @override
  _StudentBookReaderState createState() => _StudentBookReaderState();
}

class _StudentBookReaderState extends State<StudentBookReader>
    with AfterLayoutMixin<StudentBookReader> {
  // PDFViewController _controller;
  @override
  void afterFirstLayout(BuildContext context) {
    final StudentFileProvider fileProvider =
        Provider.of<StudentFileProvider>(context);
    fileProvider.downloadPDFFromURL(context,
        "https://file-examples.com/wp-content/uploads/2017/10/file-example_PDF_1MB.pdf");
  }

  @override
  Widget build(BuildContext context) {
    final StudentFileProvider fileProvider =
        Provider.of<StudentFileProvider>(context);
    final file = fileProvider.file;
    final book = widget.book;
    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${book.title}',
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            ],
          ),
          actions: <Widget>[
            // IconButton(icon: ImageIcon(assetImage('search')), onPressed: () {})
          ],
        ),
        body: Stack(
          children: <Widget>[
            file == null
                ? Container()
                : PDFView(
                    filePath: file.path,
                    enableSwipe: true,
                    swipeHorizontal: true,
                    autoSpacing: false,
                    pageFling: false,
                    onRender: (int i) {},
                    onError: (error) {},
                    onPageError: (int i, error) {},
                    onViewCreated: (PDFViewController _controller) {},
                    onPageChanged: (int i, int total) {},
                  ),
          ],
        ));
  }
}
