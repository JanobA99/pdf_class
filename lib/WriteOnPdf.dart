import 'dart:convert';
import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdfclass/PdfPreviewScreen.dart';
import 'package:pdfclass/moduls/Site.dart';
import 'package:some_calendar/some_calendar.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static String siteImage = "", snagImage = "";
  static int snag = 0;
  static int _listLenght = 3;
  static List<Site> _listSite = [
    Site("+998944375257", "name", "location", "site\nName", siteImage, null),
  ];

  static List<Snags> _list = [
    Snags(
        "snagLocation",
        "AssignedTo",
        "snagPriority",
        "snagTitle",
        "snagDescription",
        snagDate,
        snagDate,
        snagImage,
        snagImage,
        snagImage,
        snagImage,
        false,
        false),
    Snags(
        "snagLocation1",
        "AssignedTo1",
        "snagPriority1",
        "snagTitle1",
        "snagDescription1",
        snagDate,
        snagDate,
        null,
        snagImage,
        snagImage,
        snagImage,
        false,
        true),
    Snags(
        "snagLocation2",
        "AssignedTo2",
        "snagPriority2",
        "snagTitle2",
        "snagDescription2",
        snagDate,
        snagDate,
        snagImage,
        snagImage,
        snagImage,
        snagImage,
        true,
        false),
    Snags(
        "snagLocation3",
        "AssignedTo3",
        "snagPriority3",
        "snagTitle3",
        "snagDescription3",
        snagDate,
        snagDate,
        snagImage,
        snagImage,
        snagImage,
        snagImage,
        false,
        false),
    Snags(
        "snagLocation4",
        "AssignedTo4",
        "snagPriority4",
        "snagTitle4",
        "snagDescription4",
        snagDate,
        snagDate,
        snagImage,
        snagImage,
        snagImage,
        snagImage,
        false,
        false),
    Snags(
        "snagLocation5",
        "AssignedTo5",
        "snagPriority5",
        "snagTitle5",
        "snagDescription5",
        snagDate,
        snagDate,
        snagImage,
        snagImage,
        snagImage,
        snagImage,
        false,
        false),
    Snags(
        "snagLocation",
        "AssignedTo",
        "snagPriority",
        "snagTitle6",
        "snagDescription",
        snagDate,
        snagDate,
        snagImage,
        snagImage,
        snagImage,
        snagImage,
        false,
        false),
    Snags(
        "snagLocation",
        "AssignedTo",
        "snagPriority",
        "snagTitle7",
        "snagDescription",
        snagDate,
        snagDate,
        snagImage,
        snagImage,
        snagImage,
        snagImage,
        false,
        false),
    Snags(
        "snagLocation",
        "AssignedTo",
        "snagPriority",
        "snagTitle8",
        "snagDescription",
        snagDate,
        snagDate,
        snagImage,
        snagImage,
        snagImage,
        snagImage,
        false,
        false),
  ];

  static final bytes = File(imagePath).readAsBytesSync();
  static String img64 = base64Encode(bytes);
  static String imagePath;
  File selectedImage;
  Future getImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagePath = image.path;
      selectedImage = image;
      siteImage = img64;
    });
  }

  static pw.Document pdf = pw.Document();
  Future savePdf() async {
    final savedFile = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOCUMENTS);
    print(savedFile); // /storage/emulated/0/Pictures
    var file = File("$savedFile/example.pdf");
    file.writeAsBytesSync(pdf.save());
  }

  static writeSiteOnPdf() {
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.ListView.builder(
              itemBuilder: (pw.Context context, int index) =>
                  buildSiteOnPdf(context, index),
              itemCount: _listSite.length);
        }));
  }

  static pw.Widget buildSiteOnPdf(pw.Context context, int index) {
    int closedInt = 0;
    int noClosedInt = 0;
    for (int i = 0; i < _list.length; i++) {
      _list[i].classStatus ? closedInt++ : noClosedInt++;
    }
    final imageCompany = PdfImage.file(
      pdf.document,
      bytes: base64Decode(_listSite[index].siteImage),
    );
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            imageCompany != null
                ? pw.Image(
                    imageCompany,
                    width: 200,
                    height: 200,
                  )
                : pw.Container(width: 200, height: 200),
          ]),
          pw.SizedBox(height: 130),
          pw.Header(level: 1, child: pw.Text("")),
          pw.Paragraph(
              textAlign: pw.TextAlign.left,
              text: _listSite[index].siteName,
              style:
                  pw.TextStyle(fontSize: 40, fontWeight: pw.FontWeight.bold)),
          pw.Paragraph(
            style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            text: _listSite[index].location,
          ),
          pw.SizedBox(height: 50),
          pw.Column(children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Text("${_list.length}",
                      style: pw.TextStyle(
                        fontSize: 40,
                        fontWeight: pw.FontWeight.bold,
                      )),
                  pw.Text("$closedInt",
                      style: pw.TextStyle(
                          fontSize: 40,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColor.fromHex('#008000'))),
                  pw.Text("$noClosedInt",
                      style: pw.TextStyle(
                          fontSize: 40,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColor.fromHex('#F96B4C'))),
                ]),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Text('Snags Identified',
                      style: pw.TextStyle(
                          fontSize: 20, fontWeight: pw.FontWeight.bold)),
                  pw.Text('Snags Closed',
                      style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColor.fromHex('#008000'))),
                  pw.Text('Snags in Progress',
                      style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColor.fromHex('#F96B4C'))),
                ]),
            pw.SizedBox(
              height: 20,
            ),
          ]),
          pw.SizedBox(height: 20),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Paragraph(text: "Prepared by:"),
            pw.Paragraph(
                textAlign: pw.TextAlign.left,
                text: _listSite[index].name,
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Paragraph(
                      textAlign: pw.TextAlign.left,
                      text: _listSite[index].telephoneNumber,
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold)),
                  pw.Paragraph(
                      textAlign: pw.TextAlign.left,
                      text:
                          "Signature: ${_listSite[index].signature == null ? "............" : _listSite[index].signature}",
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold)),
                ])
          ]),
        ]);
  }

  static DateTime selectedDate;
  static String snagDate = Jiffy(selectedDate).yMMMd;

  static final bytesSnag = File(imagePathSnag).readAsBytesSync();
  static String img64Snag = base64Encode(bytesSnag);
  static String imagePathSnag;
  File selectedSnagImage;
  Future getSnagImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagePathSnag = image.path;
      selectedSnagImage = image;
      snagImage = img64Snag;
    });
  }

  static writeSnags() {
    pdf.addPage(pw.MultiPage(
        margin: pw.EdgeInsets.all(32),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
              pw.ListView.builder(
                  itemBuilder: (pw.Context context, int index) =>
                      buildSnags(context, index),
                  itemCount: _listLenght)
            ]));
  }

  static pw.Widget buildSnags(pw.Context context, int index) {
    final imageSnag = _list[index + snag].snagImage != null
        ? PdfImage.file(
            pdf.document,
            bytes: base64Decode("${_list[index + snag].snagImage}"),
          )
        : null;
    final imageSnag1 = PdfImage.file(
      pdf.document,
      bytes: base64Decode("${_list[index + snag].snagImage1}"),
    );
    final imageSnag2 = PdfImage.file(
      pdf.document,
      bytes: base64Decode("${_list[index + snag].snagImage2}"),
    );
    final imageSnag3 = PdfImage.file(
      pdf.document,
      bytes: base64Decode("${_list[index + snag].snagImage3}"),
    );
    return pw.Column(children: [
      pw.Container(
          padding: pw.EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          color: PdfColor.fromHex('#F9F5F4'),
          height: 210,
          width: 530,
          child: pw.Row(children: [
            imageSnag != null
                ? pw.Container(
                    width: 200,
                    height: 200,
                    child: pw.Image(imageSnag,
                        width: 200, height: 200, fit: pw.BoxFit.fill),
                  )
                : pw.Container(),
            pw.Column(children: [
              pw.Row(children: [
                pw.Container(
                  padding: pw.EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  width: imageSnag != null ? 155 : 255,
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Paragraph(
                            textAlign: pw.TextAlign.left,
                            text:
                                "Location: ${_list[index + snag].snagLocation}",
                            style: pw.TextStyle(fontSize: 10)),
                        pw.Paragraph(
                            textAlign: pw.TextAlign.left,
                            text:
                                "Assigned to:  ${_list[index + snag].snagAssignedTo}",
                            style: pw.TextStyle(fontSize: 10)),
                      ]),
                ),
                pw.SizedBox(width: 10),
                pw.Container(
                  padding: pw.EdgeInsets.symmetric(
                    horizontal: 2,
                  ),
                  width: imageSnag != null ? 155 : 255,
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Paragraph(
                            textAlign: pw.TextAlign.left,
                            text: "Date:  ${_list[index + snag].snagDate}",
                            style: pw.TextStyle(fontSize: 10)),
                        pw.Paragraph(
                            textAlign: pw.TextAlign.left,
                            text:
                                "Priority:  ${_list[index + snag].snagPriority}",
                            style: pw.TextStyle(fontSize: 10)),
                      ]),
                ),
              ]),
              pw.Container(
                  margin: pw.EdgeInsets.symmetric(horizontal: 10),
                  color: PdfColor.fromHex('#FFFFFF'),
                  padding: pw.EdgeInsets.only(
                    top: 2,
                    bottom: 2,
                    right: 4,
                    left: 4,
                  ),
                  height: 120,
                  width: imageSnag != null ? 305 : 505,
                  child: _list[index + snag].classStatus
                      ? pw.Container()
                      : pw.Column(children: [
                          pw.Paragraph(
                              textAlign: pw.TextAlign.left,
                              text: " ${_list[index + snag].snagTitle}",
                              style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Paragraph(
                              textAlign: pw.TextAlign.left,
                              text: " ${_list[index + snag].snagDescription}",
                              style: pw.TextStyle(fontSize: 10)),
                        ])),
              _list[index + snag].classStatus
                  ? pw.Row(children: [
                      pw.Container(
                        padding: pw.EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        width: imageSnag != null ? 155 : 255,
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Paragraph(
                                  textAlign: pw.TextAlign.left,
                                  text:
                                      "Due Data:  ${_list[index + snag].snagDate}",
                                  style: pw.TextStyle(fontSize: 10)),
                            ]),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Container(
                        padding: pw.EdgeInsets.symmetric(
                          horizontal: 2,
                        ),
                        width: imageSnag != null ? 155 : 255,
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Row(children: [
                                pw.Paragraph(
                                    textAlign: pw.TextAlign.left,
                                    text: "Status: ",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Paragraph(
                                  textAlign: pw.TextAlign.left,
                                  text: "CLOSED",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      color: PdfColor.fromHex('#16A937')),
                                ),
                              ])
                            ]),
                      ),
                    ])
                  : pw.Container(),
            ]),
          ])),
      _list[index + snag].confirmedStatus
          ? pw.Container(
              padding: pw.EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              color: PdfColor.fromHex('#F9F5F4'),
              height: 210,
              width: 530,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Container(
                      width: 164,
                      height: 170,
                      child: pw.Image(imageSnag1,
                          width: 164, height: 170, fit: pw.BoxFit.fill),
                    ),
                    pw.Container(
                      width: 164,
                      height: 170,
                      child: pw.Image(imageSnag2,
                          width: 164, height: 170, fit: pw.BoxFit.fill),
                    ),
                    pw.Container(
                      width: 164,
                      height: 170,
                      child: pw.Image(imageSnag3,
                          width: 164, height: 170, fit: pw.BoxFit.fill),
                    ),
                  ]))
          : pw.Container(),
      pw.SizedBox(height: 20),
    ]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Flutter"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (_) => SomeCalendar(
                              mode: SomeMode.Single,
                              isWithoutDialog: false,
                              startDate: Jiffy().subtract(years: 3),
                              lastDate: Jiffy().add(months: 9),
                              selectedDate: selectedDate,
                              done: (date) {
                                setState(() {
                                  selectedDate = date;
                                  print(selectedDate.toString());
                                });
                              },
                            )),
                    child: Text("addDate"),
                  ),
                  Text(selectedDate.toString()),
                ],
              ),
              GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: selectedImage != null
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          height: 170,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.file(
                              selectedImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          height: 170,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)),
                          width: MediaQuery.of(context).size.width,
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.black45,
                          ),
                        )),
              GestureDetector(
                  onTap: () {
                    getSnagImage();
                  },
                  child: selectedSnagImage != null
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          height: 170,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.file(
                              selectedSnagImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          height: 170,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)),
                          width: MediaQuery.of(context).size.width,
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.black45,
                          ),
                        )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          writeSiteOnPdf();
          for (int i = 0; i < _list.length; i++) {
            if (_list[i].confirmedStatus) {
              setState(() {
                _listLenght = 2;
              });
            }
            if (i == _listLenght - 1) {
              writeSnags();
              setState(() {
                _listLenght = 3;
                snag -= 1;
              });
            }
            if (i >= snag + 3) {
              snag += 3;
              writeSnags();
              setState(() {
                _listLenght = 3;
              });
            }
          }

          await savePdf();

          final savedFile = await ExtStorage.getExternalStoragePublicDirectory(
              ExtStorage.DIRECTORY_DOCUMENTS);

          String fullPath = "$savedFile/example.pdf";

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PdfPreviewScreen(
                        path: fullPath,
                      )));
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
