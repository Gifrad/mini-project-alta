
class ProfileStore {
  String? id;
  String? imageUrl;
  String? nameStore;
  String? addressStore;
  String? numberStore;

  ProfileStore(
      {this.id,
      this.imageUrl,
      this.nameStore,
      this.addressStore,
      this.numberStore});

  factory ProfileStore.fromJson(Map<String, dynamic> json) => ProfileStore(
        id: json['id'],
        imageUrl: json['imageUrl'],
        nameStore: json['nameStore'],
        addressStore: json['addressStore'],
        numberStore: json['numberStore'],
      );
}
