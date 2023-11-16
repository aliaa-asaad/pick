class HomeSliderModel {
  List<Slider>? slider;

  HomeSliderModel({this.slider});

  HomeSliderModel.fromJson(Map<String, dynamic> json) {
    if (json['slider'] != null) {
      slider = <Slider>[];
      json['slider'].forEach((v) {
        slider!.add(Slider.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (slider != null) {
      data['slider'] = slider!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slider {
  String? imageUrl;

  Slider({this.imageUrl});

  Slider.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageUrl'] = imageUrl;
    return data;
  }
}
