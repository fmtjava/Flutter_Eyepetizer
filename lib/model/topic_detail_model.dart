import 'issue_model.dart';

class TopicDetailModel {
  int id;
  String headerImage;
  String brief;
  String text;
  String shareLink;
  List<TopicDetailItemData> itemList;
  int count;

  TopicDetailModel(
      {this.id,
      this.headerImage='',
      this.brief='',
      this.text='',
      this.shareLink,
      this.itemList,
      this.count});

  TopicDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    headerImage = json['headerImage'];
    brief = json['brief'];
    text = json['text'];
    shareLink = json['shareLink'];
    if (json['itemList'] != null) {
      itemList = new List<TopicDetailItemData>();
      json['itemList'].forEach((v) {
        itemList.add(new TopicDetailItemData.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['headerImage'] = this.headerImage;
    data['brief'] = this.brief;
    data['text'] = this.text;
    data['shareLink'] = this.shareLink;
    if (this.itemList != null) {
      data['itemList'] = this.itemList.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class TopicDetailItemData {
  String type;
  ContentDataModel data;
  int id;
  int adIndex;

  TopicDetailItemData({this.type, this.data, this.id, this.adIndex});

  TopicDetailItemData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? new ContentDataModel.fromJson(json['data']) : null;
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

class ContentDataModel {
  String dataType;
  Header header;
  ContentModel content;

  ContentDataModel({this.dataType, this.header, this.content});

  ContentDataModel.fromJson(Map<String, dynamic> json) {
    dataType = json['dataType'];
    header =
        json['header'] != null ? new Header.fromJson(json['header']) : null;
    content =
        json['content'] != null ? new ContentModel.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataType'] = this.dataType;
    if (this.header != null) {
      data['header'] = this.header.toJson();
    }
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    return data;
  }
}

class Header {
  int id;
  String actionUrl;
  Null labelList;
  String icon;
  String iconType;
  int time;
  bool showHateVideo;
  String followType;
  int tagId;
  String issuerName;
  bool topShow;

  Header(
      {this.id,
      this.actionUrl,
      this.labelList,
      this.icon,
      this.iconType,
      this.time,
      this.showHateVideo,
      this.followType,
      this.tagId,
      this.issuerName,
      this.topShow});

  Header.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    actionUrl = json['actionUrl'];
    labelList = json['labelList'];
    icon = json['icon'];
    iconType = json['iconType'];
    time = json['time'];
    showHateVideo = json['showHateVideo'];
    followType = json['followType'];
    tagId = json['tagId'];
    issuerName = json['issuerName'];
    topShow = json['topShow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['actionUrl'] = this.actionUrl;
    data['labelList'] = this.labelList;
    data['icon'] = this.icon;
    data['iconType'] = this.iconType;
    data['time'] = this.time;
    data['showHateVideo'] = this.showHateVideo;
    data['followType'] = this.followType;
    data['tagId'] = this.tagId;
    data['issuerName'] = this.issuerName;
    data['topShow'] = this.topShow;
    return data;
  }
}

class ContentModel{
  String type;
  Data data;

  ContentModel({this.type, this.data});

  ContentModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data =
    json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.data != null) {
      data['header'] = this.data.toJson();
    }
    return data;
  }
}