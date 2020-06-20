import 'package:flutter_eyepetizer/model/paging_model.dart';

class IssueEntity {
  int nextPublishTime;
  String newestIssueType;
  String nextPageUrl;
  List<Issue> issueList;

  IssueEntity(
      {this.nextPublishTime,
      this.newestIssueType,
      this.nextPageUrl,
      this.issueList});

  IssueEntity.fromJson(Map<String, dynamic> json) {
    nextPublishTime = json['nextPublishTime'];
    newestIssueType = json['newestIssueType'];
    nextPageUrl = json['nextPageUrl'];
    if (json['issueList'] != null) {
      issueList = new List<Issue>();
      (json['issueList'] as List).forEach((v) {
        issueList.add(new Issue.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nextPublishTime'] = this.nextPublishTime;
    data['newestIssueType'] = this.newestIssueType;
    data['nextPageUrl'] = this.nextPageUrl;
    if (this.issueList != null) {
      data['issueList'] = this.issueList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Issue extends PagingModel<Item>{
  int total;
  int date;
  int publishTime;
  int releaseTime;
  int count;
  String type;

  Issue(
      {this.total,
      this.date,
      this.publishTime,
      this.releaseTime,
      this.count,
      this.type});

  Issue.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    date = json['date'];
    publishTime = json['publishTime'];
    releaseTime = json['releaseTime'];
    count = json['count'];
    if (json['itemList'] != null) {
      itemList = new List<Item>();
      (json['itemList'] as List).forEach((v) {
        itemList.add(new Item.fromJson(v));
      });
    }
    type = json['type'];
    nextPageUrl = json['nextPageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['date'] = this.date;
    data['publishTime'] = this.publishTime;
    data['releaseTime'] = this.releaseTime;
    data['count'] = this.count;
    if (this.itemList != null) {
      data['itemList'] = this.itemList.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['nextPageUrl'] = this.nextPageUrl;
    return data;
  }
}

class Item {
  Data data;
  int adIndex;
  int id;
  String type;

  Item({this.data, this.adIndex, this.id, this.type});

  Item.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Header {
  String actionUrl;
  String description;
  bool expert;
  String icon;
  String iconType;
  int id;
  bool ifPgc;
  bool ifShowNotificationIcon;
  String title;
  int uid;

  Header(
      {this.actionUrl,
      this.description,
      this.expert,
      this.icon,
      this.iconType,
      this.id,
      this.ifPgc,
      this.ifShowNotificationIcon,
      this.title,
      this.uid});

  Header.fromJson(Map<String, dynamic> json) {
    actionUrl = json['actionUrl'];
    description = json['description'];
    expert = json['expert'];
    icon = json['icon'];
    iconType = json['iconType'];
    id = json['id'];
    ifPgc = json['ifPgc'];
    ifShowNotificationIcon = json['ifShowNotificationIcon'];
    title = json['title'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actionUrl'] = this.actionUrl;
    data['description'] = this.description;
    data['expert'] = this.expert;
    data['icon'] = this.icon;
    data['iconType'] = this.iconType;
    data['id'] = this.id;
    data['ifPgc'] = this.ifPgc;
    data['ifShowNotificationIcon'] = this.ifShowNotificationIcon;
    data['title'] = this.title;
    data['uid'] = this.uid;
    return data;
  }
}

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
      subtitles = new List<Null>();
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
      tags = new List<Tag>();
      (json['tags'] as List).forEach((v) {
        tags.add(new Tag.fromJson(v));
      });
    }
    if (json['labelList'] != null) {
      labelList = new List<Null>();
    }
    if (json['playInfo'] != null) {
      playInfo = new List<PlayInfo>();
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

class Data {
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
  bool ad;
  Author author;
  String dataType;
  int searchWeight;
  Consumption consumption;
  bool played;
  List<Tag> tags;
  List<PlayInfo> playInfo;
  bool ifLimitVideo;
  WebUrl webUrl;
  String category;
  int idx;
  String resourceType;
  String text;
  Header header;
  List<Item> itemList;
  String time = DateTime.now().toString();

  Data(
      {this.date,
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
      this.ad,
      this.author,
      this.dataType,
      this.searchWeight,
      this.consumption,
      this.played,
      this.tags,
      this.playInfo,
      this.ifLimitVideo,
      this.webUrl,
      this.category,
      this.idx,
      this.resourceType,
      this.text,
      this.header,
      this.itemList});

  Data.fromJson(Map<String, dynamic> json) {
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
      tags = new List<Tag>();
      (json['tags'] as List).forEach((v) {
        tags.add(new Tag.fromJson(v));
      });
    }
    if (json['playInfo'] != null) {
      playInfo = new List<PlayInfo>();
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
    header =
        json['header'] != null ? new Header.fromJson(json['header']) : null;
    if (json['itemList'] != null) {
      itemList = new List<Item>();
      (json['itemList'] as List).forEach((v) {
        itemList.add(new Item.fromJson(v));
      });
    }
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
    if (this.header != null) {
      data['header'] = this.header.toJson();
    }
    if (this.itemList != null) {
      data['itemList'] = this.itemList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cover {
  String feed;
  String detail;
  String blurred;
  String homepage;

  Cover({this.feed, this.detail, this.blurred, this.homepage});

  Cover.fromJson(Map<String, dynamic> json) {
    feed = json['feed'];
    detail = json['detail'];
    blurred = json['blurred'];
    homepage = json['homepage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feed'] = this.feed;
    data['detail'] = this.detail;
    data['blurred'] = this.blurred;
    data['homepage'] = this.homepage;
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

class Provide {
  String icon;
  String name;
  String alias;

  Provide({this.icon, this.name, this.alias});

  Provide.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    name = json['name'];
    alias = json['alias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['name'] = this.name;
    data['alias'] = this.alias;
    return data;
  }
}

class Author {
  IssueIssuelistItemlistDataAuthorShield shield;
  bool expert;
  int approvedNotReadyVideoCount;
  String icon;
  String link;
  String description;
  int videoNum;
  IssueIssuelistItemlistDataAuthorFollow follow;
  int recSort;
  bool ifPgc;
  String name;
  int latestReleaseTime;
  int id;

  Author(
      {this.shield,
      this.expert,
      this.approvedNotReadyVideoCount,
      this.icon,
      this.link,
      this.description,
      this.videoNum,
      this.follow,
      this.recSort,
      this.ifPgc,
      this.name,
      this.latestReleaseTime,
      this.id});

  Author.fromJson(Map<String, dynamic> json) {
    shield = json['shield'] != null
        ? new IssueIssuelistItemlistDataAuthorShield.fromJson(json['shield'])
        : null;
    expert = json['expert'];
    approvedNotReadyVideoCount = json['approvedNotReadyVideoCount'];
    icon = json['icon'];
    link = json['link'];
    description = json['description'];
    videoNum = json['videoNum'];
    follow = json['follow'] != null
        ? new IssueIssuelistItemlistDataAuthorFollow.fromJson(json['follow'])
        : null;
    recSort = json['recSort'];
    ifPgc = json['ifPgc'];
    name = json['name'];
    latestReleaseTime = json['latestReleaseTime'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shield != null) {
      data['shield'] = this.shield.toJson();
    }
    data['expert'] = this.expert;
    data['approvedNotReadyVideoCount'] = this.approvedNotReadyVideoCount;
    data['icon'] = this.icon;
    data['link'] = this.link;
    data['description'] = this.description;
    data['videoNum'] = this.videoNum;
    if (this.follow != null) {
      data['follow'] = this.follow.toJson();
    }
    data['recSort'] = this.recSort;
    data['ifPgc'] = this.ifPgc;
    data['name'] = this.name;
    data['latestReleaseTime'] = this.latestReleaseTime;
    data['id'] = this.id;
    return data;
  }
}

class IssueIssuelistItemlistDataAuthorShield {
  int itemId;
  String itemType;
  bool shielded;

  IssueIssuelistItemlistDataAuthorShield(
      {this.itemId, this.itemType, this.shielded});

  IssueIssuelistItemlistDataAuthorShield.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    itemType = json['itemType'];
    shielded = json['shielded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['itemType'] = this.itemType;
    data['shielded'] = this.shielded;
    return data;
  }
}

class IssueIssuelistItemlistDataAuthorFollow {
  int itemId;
  String itemType;
  bool followed;

  IssueIssuelistItemlistDataAuthorFollow(
      {this.itemId, this.itemType, this.followed});

  IssueIssuelistItemlistDataAuthorFollow.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    itemType = json['itemType'];
    followed = json['followed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['itemType'] = this.itemType;
    data['followed'] = this.followed;
    return data;
  }
}

class Consumption {
  int shareCount;
  int replyCount;
  int collectionCount;

  Consumption({this.shareCount, this.replyCount, this.collectionCount});

  Consumption.fromJson(Map<String, dynamic> json) {
    shareCount = json['shareCount'];
    replyCount = json['replyCount'];
    collectionCount = json['collectionCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shareCount'] = this.shareCount;
    data['replyCount'] = this.replyCount;
    data['collectionCount'] = this.collectionCount;
    return data;
  }
}

class Tag {
  String tagRecType;
  String headerImage;
  String actionUrl;
  int communityIndex;
  String name;
  int id;
  String bgPicture;

  Tag(
      {this.tagRecType,
      this.headerImage,
      this.actionUrl,
      this.communityIndex,
      this.name,
      this.id,
      this.bgPicture});

  Tag.fromJson(Map<String, dynamic> json) {
    tagRecType = json['tagRecType'];
    headerImage = json['headerImage'];
    actionUrl = json['actionUrl'];
    communityIndex = json['communityIndex'];
    name = json['name'];
    id = json['id'];
    bgPicture = json['bgPicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tagRecType'] = this.tagRecType;
    data['headerImage'] = this.headerImage;
    data['actionUrl'] = this.actionUrl;
    data['communityIndex'] = this.communityIndex;
    data['name'] = this.name;
    data['id'] = this.id;
    data['bgPicture'] = this.bgPicture;
    return data;
  }
}

class PlayInfo {
  String name;
  int width;
  List<IssueIssuelistItemlistDataPlayinfoUrllist> urlList;
  String type;
  String url;
  int height;

  PlayInfo(
      {this.name, this.width, this.urlList, this.type, this.url, this.height});

  PlayInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    width = json['width'];
    if (json['urlList'] != null) {
      urlList = new List<IssueIssuelistItemlistDataPlayinfoUrllist>();
      (json['urlList'] as List).forEach((v) {
        urlList.add(new IssueIssuelistItemlistDataPlayinfoUrllist.fromJson(v));
      });
    }
    type = json['type'];
    url = json['url'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['width'] = this.width;
    if (this.urlList != null) {
      data['urlList'] = this.urlList.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['url'] = this.url;
    data['height'] = this.height;
    return data;
  }
}

class IssueIssuelistItemlistDataPlayinfoUrllist {
  int size;
  String name;
  String url;

  IssueIssuelistItemlistDataPlayinfoUrllist({this.size, this.name, this.url});

  IssueIssuelistItemlistDataPlayinfoUrllist.fromJson(
      Map<String, dynamic> json) {
    size = json['size'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class WebUrl {
  String forWeibo;
  String raw;

  WebUrl({this.forWeibo, this.raw});

  WebUrl.fromJson(Map<String, dynamic> json) {
    forWeibo = json['forWeibo'];
    raw = json['raw'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['forWeibo'] = this.forWeibo;
    data['raw'] = this.raw;
    return data;
  }
}
