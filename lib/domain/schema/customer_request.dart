class CustomerRequest {
  String? email;
  String? fullAddress;
  String? fullName;
  String? phone;

  CustomerRequest({this.email, this.fullAddress, this.fullName, this.phone});

  CustomerRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullAddress = json['full_address'];
    fullName = json['full_name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['full_address'] = this.fullAddress;
    data['full_name'] = this.fullName;
    data['phone'] = this.phone;
    return data;
  }
}