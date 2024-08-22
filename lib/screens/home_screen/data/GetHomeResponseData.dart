class Feed {
  final List<Entry> entry;

  Feed({required this.entry});

  factory Feed.fromJson(Map<String, dynamic> json) {
    var entriesList = json['feed']['entry'] as List;
    List<Entry> entries =
    entriesList.map((entryJson) => Entry.fromJson(entryJson)).toList();

    return Feed(entry: entries);
  }
}

class Entry {
  final Name name;
  final List<Image> images;

  Entry({required this.name, required this.images});

  factory Entry.fromJson(Map<String, dynamic> json) {
    var nameJson = json['im:name'];
    var imagesJson = json['im:image'] as List;

    Name entryName = Name.fromJson(nameJson);
    List<Image> entryImages =
    imagesJson.map((imageJson) => Image.fromJson(imageJson)).toList();

    return Entry(name: entryName, images: entryImages);
  }
}

class Name {
  final String label;

  Name({required this.label});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(label: json['label']);
  }
}

class Image {
  final String label;

  Image({required this.label});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(label: json['label']);
  }
}
