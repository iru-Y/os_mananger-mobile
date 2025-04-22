class CustomerRequest {
  String? email;
  String? fullAddress;
  String? fullName;
  String? phone;
  String? description;

  CustomerRequest({
    this.email,
    this.fullAddress,
    this.fullName,
    this.phone,
    this.description,
  });

  CustomerRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullAddress = json['full_address'];
    fullName = json['full_name'];
    phone = json['phone'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['full_address'] = fullAddress;
    data['full_name'] = fullName;
    data['phone'] = phone;
    data['description'] = description;
    return data;
  }
}
