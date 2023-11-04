//// [PROFILE]

class ExpertProfile {
  ExpertProfile({
    String? expertId,
    String? expertName,
    String? expertMobileNumber,
    String? expertEmailId,
    String? stateName,
    String? password,
    String? docUrl,
    String? imageUrl,
    String? docNumber,
  }) {
    _expertId = expertId;
    _expertName = expertName;
    _expertMobileNumber = expertMobileNumber;
    _expertEmailId = expertEmailId;
    _stateName = stateName;
    _password = password;
    _docUrl = docUrl;
    _imageUrl = imageUrl;
    _docNumber = docNumber;
  }

  ExpertProfile.fromJson(dynamic json) {
    _expertId = json['expertId'];
    _expertName = json['expertName'];
    _expertMobileNumber = json['expertMobileNumber'];
    _expertEmailId = json['expertEmailId'];
    _stateName = json['stateName'];
    _password = json['password'];
    _docUrl = json['docUrl'];
    _imageUrl = json['imageUrl'];
    _docNumber = json['docNumber'];
  }

  String? _expertId;
  String? _expertName;
  String? _expertMobileNumber;
  String? _expertEmailId;
  String? _stateName;
  String? _password;
  String? _docUrl;
  String? _imageUrl;
  String? _docNumber;

  ExpertProfile copyWith({
    String? expertId,
    String? expertName,
    String? expertMobileNumber,
    String? expertEmailId,
    String? stateName,
    String? password,
    String? docUrl,
    String? imageUrl,
    String? docNumber,
  }) =>
      ExpertProfile(
        expertId: expertId ?? _expertId,
        expertName: expertName ?? _expertName,
        expertMobileNumber: expertMobileNumber ?? _expertMobileNumber,
        expertEmailId: expertEmailId ?? _expertEmailId,
        stateName: stateName ?? _stateName,
        password: password ?? _password,
        docUrl: docUrl ?? _docUrl,
        imageUrl: imageUrl ?? _imageUrl,
        docNumber: docNumber ?? _docNumber,
      );

  String? get expertId => _expertId;

  String? get expertName => _expertName;

  String? get expertMobileNumber => _expertMobileNumber;

  String? get expertEmailId => _expertEmailId;

  String? get stateName => _stateName;

  String? get password => _password;

  String? get docUrl => _docUrl;

  String? get imageUrl => _imageUrl;

  String? get docNumber => _docNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['expertId'] = _expertId;
    map['expertName'] = _expertName;
    map['expertMobileNumber'] = _expertMobileNumber;
    map['expertEmailId'] = _expertEmailId;
    map['stateName'] = _stateName;
    map['password'] = _password;
    map['docUrl'] = _docUrl;
    map['imageUrl'] = _imageUrl;
    map['docNumber'] = _docNumber;
    return map;
  }
}

class FarmerProfile {
  FarmerProfile({
    String? name,
    String? phoneNumber,
    String? imgUrl,
    String? state,
  }) {
    _name = name;
    _phoneNumber = phoneNumber;
    _imgUrl = imgUrl;
    _state = state;
  }

  FarmerProfile.fromJson(dynamic json) {
    _name = json['name'];
    _phoneNumber = json['phoneNumber'];
    _imgUrl = json['imgUrl'];
    _state = json['state'];
  }

  String? _name;
  String? _phoneNumber;
  String? _imgUrl;
  String? _state;

  FarmerProfile copyWith({
    String? name,
    String? phoneNumber,
    String? imgUrl,
    String? state,
  }) =>
      FarmerProfile(
        name: name ?? _name,
        phoneNumber: phoneNumber ?? _phoneNumber,
        imgUrl: imgUrl ?? _imgUrl,
        state: state ?? _state,
      );

  String? get name => _name;

  String? get phoneNumber => _phoneNumber;

  String? get imgUrl => _imgUrl;

  String? get state => _state;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['phoneNumber'] = _phoneNumber;
    map['imgUrl'] = _imgUrl;
    map['state'] = _state;
    return map;
  }
}
