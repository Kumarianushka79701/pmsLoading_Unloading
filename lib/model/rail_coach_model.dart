class RailCoach {
  final String? type;
  final String? detail;
  final String? gauge;
  final String? shortDetail;

  RailCoach({
    this.type,
    this.detail,
    this.gauge,
    this.shortDetail,
  });

  // Factory method for creating an instance from JSON
  factory RailCoach.fromJson(Map<String, dynamic> json) {
    return RailCoach(
      type: json['type'] as String?,
      detail: json['detail'] as String?,
      gauge: json['gauge'] as String?,
      shortDetail: json['shortdet'] as String?,
    );
  }

  // Method for converting an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'detail': detail,
      'gauge': gauge,
      'shortdet': shortDetail,
    };
  }
}

// Example function to parse a list of RailCoach from JSON
List<RailCoach> parseRailCoachList(List<dynamic> jsonList) {
  return jsonList.map((json) => RailCoach.fromJson(json as Map<String, dynamic>)).toList();
}
