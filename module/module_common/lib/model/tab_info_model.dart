class TabInfoModel {
  TabInfo tabInfo;
  PgcInfo pgcInfo;

  TabInfoModel({this.tabInfo,this.pgcInfo});

  TabInfoModel.fromJson(Map<String, dynamic> json) {
    tabInfo =
        json['tabInfo'] != null ? new TabInfo.fromJson(json['tabInfo']) : null;
    pgcInfo =
    json['pgcInfo'] != null ? new PgcInfo.fromJson(json['pgcInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tabInfo != null) {
      data['tabInfo'] = this.tabInfo.toJson();
    }
    return data;
  }
}

class TabInfo {
  List<TabInfoItem> tabList;
  int defaultIdx;

  TabInfo({this.tabList, this.defaultIdx});

  TabInfo.fromJson(Map<String, dynamic> json) {
    if (json['tabList'] != null) {
      tabList = [];
      (json['tabList'] as List).forEach((v) {
        tabList.add(new TabInfoItem.fromJson(v));
      });
    }
    defaultIdx = json['defaultIdx'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tabList != null) {
      data['tabList'] = this.tabList.map((v) => v.toJson()).toList();
    }
    data['defaultIdx'] = this.defaultIdx;
    return data;
  }
}

class TabInfoItem {
  int nameType;
  String apiUrl;
  String name;
  int tabType;
  int id;
  dynamic adTrack;

  TabInfoItem(
      {this.nameType,
      this.apiUrl,
      this.name,
      this.tabType,
      this.id,
      this.adTrack});

  TabInfoItem.fromJson(Map<String, dynamic> json) {
    nameType = json['nameType'];
    apiUrl = json['apiUrl'];
    name = json['name'];
    tabType = json['tabType'];
    id = json['id'];
    adTrack = json['adTrack'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameType'] = this.nameType;
    data['apiUrl'] = this.apiUrl;
    data['name'] = this.name;
    data['tabType'] = this.tabType;
    data['id'] = this.id;
    data['adTrack'] = this.adTrack;
    return data;
  }
}

class PgcInfo {
  String dataType;
  int id;
  String icon;
  String name;
  String brief;
  String description;
  String actionUrl;
  String area;
  String gender;
  int registDate;
  int followCount;
  Follow follow;
  bool self;
  String cover;
  int videoCount;
  int shareCount;
  int collectCount;
  int myFollowCount;
  String videoCountActionUrl;
  String myFollowCountActionUrl;
  String followCountActionUrl;
  String privateMessageActionUrl;
  int medalsNum;
  String medalsActionUrl;
  String tagNameExport;
  int worksRecCount;
  int worksSelectedCount;
  Shield shield;
  bool expert;

  PgcInfo(
      {this.dataType,
        this.id,
        this.icon,
        this.name,
        this.brief,
        this.description,
        this.actionUrl,
        this.area,
        this.gender,
        this.registDate,
        this.followCount,
        this.follow,
        this.self,
        this.cover,
        this.videoCount,
        this.shareCount,
        this.collectCount,
        this.myFollowCount,
        this.videoCountActionUrl,
        this.myFollowCountActionUrl,
        this.followCountActionUrl,
        this.privateMessageActionUrl,
        this.medalsNum,
        this.medalsActionUrl,
        this.tagNameExport,
        this.worksRecCount,
        this.worksSelectedCount,
        this.shield,
        this.expert});

  PgcInfo.fromJson(Map<String, dynamic> json) {
    dataType = json['dataType'];
    id = json['id'];
    icon = json['icon'];
    name = json['name'];
    brief = json['brief'];
    description = json['description'];
    actionUrl = json['actionUrl'];
    area = json['area'];
    gender = json['gender'];
    registDate = json['registDate'];
    followCount = json['followCount'];
    follow =
    json['follow'] != null ? new Follow.fromJson(json['follow']) : null;
    self = json['self'];
    cover = json['cover'];
    videoCount = json['videoCount'];
    shareCount = json['shareCount'];
    collectCount = json['collectCount'];
    myFollowCount = json['myFollowCount'];
    videoCountActionUrl = json['videoCountActionUrl'];
    myFollowCountActionUrl = json['myFollowCountActionUrl'];
    followCountActionUrl = json['followCountActionUrl'];
    privateMessageActionUrl = json['privateMessageActionUrl'];
    medalsNum = json['medalsNum'];
    medalsActionUrl = json['medalsActionUrl'];
    tagNameExport = json['tagNameExport'];
    worksRecCount = json['worksRecCount'];
    worksSelectedCount = json['worksSelectedCount'];
    shield =
    json['shield'] != null ? new Shield.fromJson(json['shield']) : null;
    expert = json['expert'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataType'] = this.dataType;
    data['id'] = this.id;
    data['icon'] = this.icon;
    data['name'] = this.name;
    data['brief'] = this.brief;
    data['description'] = this.description;
    data['actionUrl'] = this.actionUrl;
    data['area'] = this.area;
    data['gender'] = this.gender;
    data['registDate'] = this.registDate;
    data['followCount'] = this.followCount;
    if (this.follow != null) {
      data['follow'] = this.follow.toJson();
    }
    data['self'] = this.self;
    data['cover'] = this.cover;
    data['videoCount'] = this.videoCount;
    data['shareCount'] = this.shareCount;
    data['collectCount'] = this.collectCount;
    data['myFollowCount'] = this.myFollowCount;
    data['videoCountActionUrl'] = this.videoCountActionUrl;
    data['myFollowCountActionUrl'] = this.myFollowCountActionUrl;
    data['followCountActionUrl'] = this.followCountActionUrl;
    data['privateMessageActionUrl'] = this.privateMessageActionUrl;
    data['medalsNum'] = this.medalsNum;
    data['medalsActionUrl'] = this.medalsActionUrl;
    data['tagNameExport'] = this.tagNameExport;
    data['worksRecCount'] = this.worksRecCount;
    data['worksSelectedCount'] = this.worksSelectedCount;
    if (this.shield != null) {
      data['shield'] = this.shield.toJson();
    }
    data['expert'] = this.expert;
    return data;
  }
}

class Follow {
  String itemType;
  int itemId;
  bool followed;

  Follow({this.itemType, this.itemId, this.followed});

  Follow.fromJson(Map<String, dynamic> json) {
    itemType = json['itemType'];
    itemId = json['itemId'];
    followed = json['followed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemType'] = this.itemType;
    data['itemId'] = this.itemId;
    data['followed'] = this.followed;
    return data;
  }
}

class Shield {
  String itemType;
  int itemId;
  bool shielded;

  Shield({this.itemType, this.itemId, this.shielded});

  Shield.fromJson(Map<String, dynamic> json) {
    itemType = json['itemType'];
    itemId = json['itemId'];
    shielded = json['shielded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemType'] = this.itemType;
    data['itemId'] = this.itemId;
    data['shielded'] = this.shielded;
    return data;
  }
}
