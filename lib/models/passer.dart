class Passer {
  String id;
  String code;
  String name;
  String address;
  bool isApproved = false;
  DateTime approvedOn;
  Passer(
      {this.id,
      this.code,
      this.name,
      this.address,
      this.isApproved,
      this.approvedOn});
}
