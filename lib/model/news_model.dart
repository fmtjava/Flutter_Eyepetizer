import 'package:flutter_eyepetizer/model/paging_model.dart';

class NewsModel extends PagingModel<NewsItemModel> {
  int count;
  int total;
  bool adExist;

  NewsModel({this.count, this.total, this.adExist});

  NewsModel.fromJson(Map<String, dynamic> json) {
    if (json['itemList'] != null) {
      itemList = new List<NewsItemModel>();
      json['itemList'].forEach((v) {
        itemList.add(new NewsItemModel.fromJson(v));
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

class NewsItemModel {
  String type;
  Data data;
  int id;
  int adIndex;

  NewsItemModel({this.type, this.data, this.id, this.adIndex});

  NewsItemModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    id = json['id'];
    adIndex = json['adIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['id'] = this.id;
    data['adIndex'] = this.adIndex;
    return data;
  }
}

class Data {
  String dataType;
  int id;
  String type;
  String text;
  String actionUrl;
  List<String> titleList;
  String backgroundImage;

  Data(
      {this.dataType,
      this.id,
      this.type,
      this.text,
      this.actionUrl,
      this.titleList,
      this.backgroundImage});

  Data.fromJson(Map<String, dynamic> json) {
    dataType = json['dataType'];
    id = json['id'];
    type = json['type'];
    text = json['text'];
    actionUrl = json['actionUrl'];
    if(json['titleList'] !=null){
      titleList = json['titleList'].cast<String>();
    }
    backgroundImage = json['backgroundImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataType'] = this.dataType;
    data['id'] = this.id;
    data['type'] = this.type;
    data['text'] = this.text;
    data['actionUrl'] = this.actionUrl;
    data['titleList'] = this.titleList;
    data['backgroundImage'] = this.backgroundImage;
    return data;
  }
}
