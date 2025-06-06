import 'dart:convert';

// ignore: library_prefixes
import 'package:to_csv/to_csv.dart' as exportCSV;

class CsvController {
  List<String> header = [
    'Datum',
    'Maschinist',
    'Kommandant',
    'Typ',
    'Beschreibung',
    'Kilometer Start',
    'Kilometer Ende',
    'Getankte Liter',
    'Stromerzeuger Betrieben',
    'Stromerzeuger Tank voll',
    'Atemshutz getragen',
    'Atemshutz aufgerüstet',
    'Cafs Betrieben',
    'Cafs Tank voll',
    'Mängel',
    'Fehlendes'
  ];

  // ignore: non_constant_identifier_names
  void DownloadCSV(List<List<String>> input){
    exportCSV.myCSV(header, input, setHeadersInFirstRow: true, fileName: 'Fahrtenbuch', fieldDelimiter: ';', encodingType: latin1);
  }
}