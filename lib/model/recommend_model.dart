import 'package:flutter_eyepetizer/model/paging_model.dart';

class RecommendModel extends PagingModel<RecommendItem>{
  int count;
  int total;
  bool adExist;

  RecommendModel(
      {this.count, this.total, this.adExist});

  RecommendModel.fromJson(Map<String, dynamic> json) {
    if (json['itemList'] != null) {
      itemList = new List<RecommendItem>();
      json['itemList'].forEach((v) {
        itemList.add(new RecommendItem.fromJson(v));
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

class RecommendItem {
  String type;
  Data data;
  RecommendItem({this.type, this.data});

  RecommendItem.fromJson(Map<String, dynamic> json) {
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
  Header header;
  CommunityModel content;

  Data(
      {this.dataType,
      this.header,
      this.content});

  Data.fromJson(Map<String, dynamic> json) {
    dataType = json['dataType'];
    header =
        json['header'] != null ? new Header.fromJson(json['header']) : null;
    content = json['content'] != null
        ? new CommunityModel.fromJson(json['content'])
        : null;
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
  String icon;
  String iconType;
  bool showHateVideo;
  String followType;
  String issuerName;
  bool topShow;

  Header(
      {this.id,
      this.actionUrl,
      this.icon,
      this.iconType,
      this.showHateVideo,
      this.followType,
      this.issuerName,
      this.topShow});

  Header.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    actionUrl = json['actionUrl'];
    icon = json['icon'];
    iconType = json['iconType'];
    showHateVideo = json['showHateVideo'];
    followType = json['followType'];
    issuerName = json['issuerName'];
    topShow = json['topShow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['actionUrl'] = this.actionUrl;
    data['icon'] = this.icon;
    data['iconType'] = this.iconType;
    data['showHateVideo'] = this.showHateVideo;
    data['followType'] = this.followType;
    data['issuerName'] = this.issuerName;
    data['topShow'] = this.topShow;
    return data;
  }
}

class CommunityModel {
  String type;
  ContentData data;

  CommunityModel({this.type, this.data});

  CommunityModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null ? new ContentData.fromJson(json['data']) : null;
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

class ContentData {
  String dataType;
  int id;
  String title;
  String description;
  String library;
  List<Tags> tags;
  Consumption consumption;
  String resourceType;
  int uid;
  bool collected;
  bool reallyCollected;
  Owner owner;
  Cover cover;
  String checkStatus;
  String area;
  String city;
  bool ifMock;
  String validateStatus;
  String validateResult;
  bool addWatermark;
  String url;
  String playUrl;
  int width;
  int height;
  List<String> urls;
  List<String> urlsWithWatermark;

  ContentData(
      {this.dataType,
      this.id,
      this.title,
      this.description,
      this.library,
      this.tags,
      this.consumption,
      this.resourceType,
      this.uid,
      this.collected,
      this.reallyCollected,
      this.owner,
      this.cover,
      this.checkStatus,
      this.area,
      this.city,
      this.ifMock,
      this.validateStatus,
      this.validateResult,
      this.addWatermark,
      this.url,
        this.playUrl,
        this.width,
        this.height,
      this.urls,
      this.urlsWithWatermark});

  ContentData.fromJson(Map<String, dynamic> json) {
    dataType = json['dataType'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    library = json['library'];
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
    consumption = json['consumption'] != null
        ? new Consumption.fromJson(json['consumption'])
        : null;
    resourceType = json['resourceType'];
    uid = json['uid'];
    collected = json['collected'];
    reallyCollected = json['reallyCollected'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    cover = json['cover'] != null ? new Cover.fromJson(json['cover']) : null;
    checkStatus = json['checkStatus'];
    area = json['area'];
    city = json['city'];
    ifMock = json['ifMock'];
    validateStatus = json['validateStatus'];
    validateResult = json['validateResult'];
    addWatermark = json['addWatermark'];
    url = json['url'];
    width = json['width'];
    height = json['height'];
    playUrl = json['playUrl'] != null ?json['playUrl']:null;
    urls = json['urls'] != null ?json['urls'].cast<String>():null;
    urlsWithWatermark = json['urlsWithWatermark'] != null ?json['urlsWithWatermark'].cast<String>():null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataType'] = this.dataType;
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['library'] = this.library;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    if (this.consumption != null) {
      data['consumption'] = this.consumption.toJson();
    }
    data['resourceType'] = this.resourceType;
    data['uid'] = this.uid;
    data['collected'] = this.collected;
    data['reallyCollected'] = this.reallyCollected;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    if (this.playUrl != null) {
      data['playUrl'] = this.playUrl;
    }
    if (this.cover != null) {
      data['cover'] = this.cover.toJson();
    }
    data['checkStatus'] = this.checkStatus;
    data['area'] = this.area;
    data['city'] = this.city;
    data['ifMock'] = this.ifMock;
    data['validateStatus'] = this.validateStatus;
    data['validateResult'] = this.validateResult;
    data['addWatermark'] = this.addWatermark;
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    if(this.urls !=null){
      data['urls'] = this.urls;
    }
    if(this.urlsWithWatermark !=null){
      data['urlsWithWatermark'] = this.urlsWithWatermark;
    }
    return data;
  }
}

class Tags {
  int id;
  String name;
  String actionUrl;
  String desc;
  String bgPicture;
  String headerImage;
  String tagRecType;
  bool haveReward;
  bool ifNewest;

  Tags(
      {this.id,
      this.name,
      this.actionUrl,
      this.desc,
      this.bgPicture,
      this.headerImage,
      this.tagRecType,
      this.haveReward,
      this.ifNewest});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    actionUrl = json['actionUrl'];
    desc = json['desc'];
    bgPicture = json['bgPicture'];
    headerImage = json['headerImage'];
    tagRecType = json['tagRecType'];
    haveReward = json['haveReward'];
    ifNewest = json['ifNewest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['actionUrl'] = this.actionUrl;
    data['desc'] = this.desc;
    data['bgPicture'] = this.bgPicture;
    data['headerImage'] = this.headerImage;
    data['tagRecType'] = this.tagRecType;
    data['haveReward'] = this.haveReward;
    data['ifNewest'] = this.ifNewest;
    return data;
  }
}

class Consumption {
  int collectionCount;
  int shareCount;
  int replyCount;
  int realCollectionCount;

  Consumption(
      {this.collectionCount,
      this.shareCount,
      this.replyCount,
      this.realCollectionCount});

  Consumption.fromJson(Map<String, dynamic> json) {
    collectionCount = json['collectionCount'];
    shareCount = json['shareCount'];
    replyCount = json['replyCount'];
    realCollectionCount = json['realCollectionCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collectionCount'] = this.collectionCount;
    data['shareCount'] = this.shareCount;
    data['replyCount'] = this.replyCount;
    data['realCollectionCount'] = this.realCollectionCount;
    return data;
  }
}

class Owner {
  String nickname;
  String avatar;
  String userType;
  bool ifPgc;
  String description;
  String area;
  String gender;
  String cover;
  String actionUrl;
  bool followed;
  bool limitVideoOpen;
  bool expert;

  Owner(
      {
      this.nickname,
      this.avatar,
      this.userType,
      this.ifPgc,
      this.description,
      this.area,
      this.gender,
      this.cover,
      this.actionUrl,
      this.followed,
      this.limitVideoOpen,
      this.expert});

  Owner.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
    avatar = json['avatar'];
    userType = json['userType'];
    ifPgc = json['ifPgc'];
    description = json['description'];
    area = json['area'];
    gender = json['gender'];
    cover = json['cover'];
    actionUrl = json['actionUrl'];
    followed = json['followed'];
    limitVideoOpen = json['limitVideoOpen'];
    expert = json['expert'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    data['userType'] = this.userType;
    data['ifPgc'] = this.ifPgc;
    data['description'] = this.description;
    data['area'] = this.area;
    data['gender'] = this.gender;
    data['cover'] = this.cover;
    data['actionUrl'] = this.actionUrl;
    data['followed'] = this.followed;
    data['limitVideoOpen'] = this.limitVideoOpen;
    data['expert'] = this.expert;
    return data;
  }
}

class Cover {
  String feed;
  String detail;

  Cover({this.feed, this.detail});

  Cover.fromJson(Map<String, dynamic> json) {
    feed = json['feed'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feed'] = this.feed;
    data['detail'] = this.detail;
    return data;
  }
}
