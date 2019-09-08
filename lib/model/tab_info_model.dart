class TabInfoModel {
  TabInfo tabInfo;

  TabInfoModel({this.tabInfo});

  TabInfoModel.fromJson(Map<String, dynamic> json) {
    tabInfo =
        json['tabInfo'] != null ? new TabInfo.fromJson(json['tabInfo']) : null;
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
      tabList = new List<TabInfoItem>();
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
