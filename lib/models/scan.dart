class Scan {
  String id;
  String code;
  String name;
  String address;
  DateTime scanAt;
  bool isAuthorized;
  Scan(
      {this.id,
      this.code,
      this.name,
      this.address,
      this.scanAt,
      this.isAuthorized});
}