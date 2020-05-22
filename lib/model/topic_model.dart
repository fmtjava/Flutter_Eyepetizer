
import 'package:flutter_eyepetizer/model/paging_model.dart';

class TopicModel extends PagingModel<TopicItemModel>{
  int count;
  int total;
  bool adExist;

  TopicModel(
      {this.count, this.total, this.adExist});

  TopicModel.fromJson(Map<String, dynamic> json) {
    if (json['itemList'] != null) {
      itemList = new List<TopicItemModel>();
      json['itemList'].forEach((v) {
        itemList.add(new TopicItemModel.fromJson(v));
      });
    }
    count = json['count'];
    total = json['total'];
    nextPageUrl = json['nextPageUrl'];
    adExist = json['adExist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.itemList != null) {
      data['itemList'] = this.itemList.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    data['total'] = this.total;
    data['nextPageUrl'] = this.nextPageUrl;
    data['adExist'] = this.adExist;
    return data;
  }
}

class TopicItemModel {
  String type;
  Data data;

  TopicItemModel({this.type, this.data});

  TopicItemModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String dataType;
  int id;
  String title;
  String description;
  String image;
  String actionUrl;
  bool shade;
  Label label;
  Null header;
  bool autoPlay;

  Data(
      {this.dataType,
        this.id,
        this.title,
        this.description,
        this.image,
        this.actionUrl,
        this.shade,
        this.label,
        this.header,
        this.autoPlay});

  Data.fromJson(Map<String, dynamic> json) {
    dataType = json['dataType'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    actionUrl = json['actionUrl'];
    shade = json['shade'];
    label = json['label'] != null ? new Label.fromJson(json['label']) : null;
    header = json['header'];
    autoPlay = json['autoPlay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataType'] = this.dataType;
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['actionUrl'] = this.actionUrl;
    data['shade'] = this.shade;
    if (this.label != null) {
      data['label'] = this.label.toJson();
    }
    data['header'] = this.header;
    data['autoPlay'] = this.autoPlay;
    return data;
  }
}

class Label {
  String text;
  String card;
  Null detail;

  Label({this.text, this.card, this.detail});

  Label.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    card = json['card'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['card'] = this.card;
    data['detail'] = this.detail;
    return data;
  }
}