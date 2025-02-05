class UserEntity {
  final String? id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? year;
  final String? location;
  //final String? district;
  final String? totalPayment;
  final String? imgPath;

  UserEntity(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.year,
      this.location,
     // this.district,
      this.imgPath,
      this.totalPayment});
}
