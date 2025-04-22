class CustomerModel {
  String? id;
  String? email;
  String? fullAddress;
  String? fullName;
  String? phone;
  String? description;

  CustomerModel({
    this.id,
    this.email,
    this.fullAddress,
    this.fullName,
    this.phone,
    this.description,
  });

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    fullAddress = json['full_address'];
    fullName = json['full_name'];
    phone = json['phone'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['full_address'] = fullAddress;
    data['full_name'] = fullName;
    data['phone'] = phone;
    data['description'] = description;
    return data;
  }
}
