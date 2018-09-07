import 'package:json_annotation/json_annotation.dart';

part 'source.g.dart';

@JsonSerializable()
class Source {
  String id;
  String name;

  Source({
    this.id,
    this.name
  });

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;

    return map;
  }

  static fromMap(Map map) {
    Source source = new Source();
    source.id = map["id"];
    source.name = map["name"];
    return source;
  }

  static final columns = ["id", "mname"];

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
  Map<String, dynamic> toJson() => _$SourceToJson(this);

}