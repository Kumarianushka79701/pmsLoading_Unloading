import 'dart:convert';

class DamageCode {
  final String? code;
  final String? detail;

  DamageCode({
    this.code,
    this.detail,
  });

  // Factory method for creating an instance from JSON
  factory DamageCode.fromJson(Map<String, dynamic> json) {
    return DamageCode(
      code: json['code'] as String?,
      detail: json['detail'] as String?,
    );
  }

  // Method for converting an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'detail': detail,
    };
  }
}

// Function to parse a list of DamageCode from JSON
List<DamageCode>? parseDamageCodeList(List<dynamic>? jsonList) {
  return jsonList?.map((json) => DamageCode.fromJson(json)).toList();
}

// Example Usage
void main() {
  const jsonData = '''[
    {
        "code": "D",
        "detail": "DAMAGED"
    },
    {
        "code": "T",
        "detail": "TORN"
    },
    {
        "code": "B",
        "detail": "BROKEN"
    },
    {
        "code": "L",
        "detail": "LEAKED"
    },
    {
        "code": "W",
        "detail": "FOUND IN WET CONDITION"
    },
    {
        "code": "O",
        "detail": "OK"
    },
    {
        "code": "S",
        "detail": "SMASHED"
    },
    {
        "code": "R",
        "detail": "ROTTEN"
    }
  ]''';

  final jsonList = parseDamageCodeList(json.decode(jsonData));

  // Example: Printing the data
  jsonList?.forEach((damageCode) {
    print('Code: ${damageCode.code}, Detail: ${damageCode.detail}');
  });
}
