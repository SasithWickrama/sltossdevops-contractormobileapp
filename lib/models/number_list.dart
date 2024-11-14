class NumberList {
  final String soId;
  final String circuit;
  final String displayname;

  NumberList({this.soId = '', this.circuit = '', this.displayname = ''});

  String getSoId() => this.soId;

  String getCct() => this.circuit;

  factory NumberList.fromJson(Map<dynamic, dynamic> parsedJson) {
    return NumberList(
        soId: parsedJson['SO_ID'] ?? "",
        circuit: parsedJson['CIRCUIT'] ?? "",
        displayname: parsedJson['DISPLAYNAME'] ?? "");
  }
}
