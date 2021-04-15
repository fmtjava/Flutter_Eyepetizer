import 'package:lib_core/model/paging_model.dart';

class FollowItemData {
  int date;
  int releaseTime;
  String description;
  bool collected;
  String remark;
  String title;
  String type;
  String playUrl;
  Cover cover;
  int duration;
  String descriptionEditor;
  String xLibrary;
  Provide provider;
  int id;
  List<Null> subtitles;
  bool ad;
  Author author;
  String dataType;
  int searchWeight;
  Consumption consumption;
  bool played;
  List<Tag> tags;
  List<Null> labelList;
  List<PlayInfo> playInfo;
  bool ifLimitVideo;
  WebUrl webUrl;
  String category;
  int idx;
  String resourceType;
  String text;

  FollowItemData({
    this.date,
    this.releaseTime,
    this.description,
    this.collected,
    this.remark,
    this.title,
    this.type,
    this.playUrl,
    this.cover,
    this.duration,
    this.descriptionEditor,
    this.xLibrary,
    this.provider,
    this.id,
    this.subtitles,
    this.ad,
    this.author,
    this.dataType,
    this.searchWeight,
    this.consumption,
    this.played,
    this.tags,
    this.labelList,
    this.playInfo,
    this.ifLimitVideo,
    this.webUrl,
    this.category,
    this.idx,
    this.resourceType,
    this.text,
  });

  FollowItemData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    releaseTime = json['releaseTime'];
    description = json['description'];
    collected = json['collected'];
    remark = json['remark'];
    title = json['title'];
    type = json['type'];
    playUrl = json['playUrl'];
    cover = json['cover'] != null ? new Cover.fromJson(json['cover']) : null;
    duration = json['duration'];
    descriptionEditor = json['descriptionEditor'];
    xLibrary = json['library'];
    provider = json['provider'] != null
        ? new Provide.fromJson(json['provider'])
        : null;
    id = json['id'];
    if (json['subtitles'] != null) {
      subtitles = [];
    }
    ad = json['ad'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    dataType = json['dataType'];
    searchWeight = json['searchWeight'];
    consumption = json['consumption'] != null
        ? new Consumption.fromJson(json['consumption'])
        : null;
    played = json['played'];
    if (json['tags'] != null) {
      tags = [];
      (json['tags'] as List).forEach((v) {
        tags.add(new Tag.fromJson(v));
      });
    }
    if (json['labelList'] != null) {
      labelList = [];
    }
    if (json['playInfo'] != null) {
      playInfo = [];
      (json['playInfo'] as List).forEach((v) {
        playInfo.add(new PlayInfo.fromJson(v));
      });
    }
    ifLimitVideo = json['ifLimitVideo'];
    webUrl =
        json['webUrl'] != null ? new WebUrl.fromJson(json['webUrl']) : null;
    category = json['category'];
    idx = json['idx'];
    resourceType = json['resourceType'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['releaseTime'] = this.releaseTime;
    data['description'] = this.description;
    data['collected'] = this.collected;
    data['remark'] = this.remark;
    data['title'] = this.title;
    data['type'] = this.type;
    data['playUrl'] = this.playUrl;
    if (this.cover != null) {
      data['cover'] = this.cover.toJson();
    }
    data['duration'] = this.duration;
    data['descriptionEditor'] = this.descriptionEditor;
    data['library'] = this.xLibrary;
    if (this.provider != null) {
      data['provider'] = this.provider.toJson();
    }
    data['id'] = this.id;
    if (this.subtitles != null) {
      data['subtitles'] = [];
    }
    data['ad'] = this.ad;
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['dataType'] = this.dataType;
    data['searchWeight'] = this.searchWeight;
    if (this.consumption != null) {
      data['consumption'] = this.consumption.toJson();
    }
    data['played'] = this.played;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    if (this.labelList != null) {
      data['labelList'] = [];
    }
    if (this.playInfo != null) {
      data['playInfo'] = this.playInfo.map((v) => v.toJson()).toList();
    }
    data['ifLimitVideo'] = this.ifLimitVideo;
    if (this.webUrl != null) {
      data['webUrl'] = this.webUrl.toJson();
    }
    data['category'] = this.category;
    data['idx'] = this.idx;
    data['resourceType'] = this.resourceType;
    data['text'] = this.text;
    return data;
  }
}

class FollowItem {
  FollowItemData data;
  int adIndex;
  int id;
  String type;

  FollowItem({this.data, this.adIndex, this.id, this.type});

  FollowItem.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new FollowItemData.fromJson(json['data']) : null;
    adIndex = json['adIndex'];
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['adIndex'] = this.adIndex;
    data['id'] = this.id;
    data['type'] = this.type;
    return data;
  }
}

class Label {
  String text;
  String card;
  String detial;
  String actionUrl;

  Label({this.text, this.card, this.detial, this.actionUrl});

  Label.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    card = json['card'];
    detial = json['detial'];
    actionUrl = json['actionUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['card'] = this.card;
    data['detial'] = this.detial;
    data['actionUrl'] = this.actionUrl;
    return data;
  }
}
