class Drinks {
  Drinks({required this.name});

  String name;

  factory Drinks.fromJson(Map<String, dynamic> json) => Drinks(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {"name": name};
}
