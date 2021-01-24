# Eyepetizer
一款基于Flutter实现的精美仿开眼视频跨平台App,适合新手入门，快速掌握Dart语言的基本语法以及快速上手flutter开发。<br /><br />
Kotlin版：[Kotlin_Eyepetizer](https://github.com/fmtjava/Kotlin_Eyepetizer)<br /><br />
Reactive Native版：[ReactNative_Eyepetizer](https://github.com/fmtjava/ReactNative_Eyepetizer)

**开源不易，如果喜欢的话希望给个 `Star` 或 `Fork` ^_^ ，谢谢**

# 项目截图
<div style="float:right">
  <img src="https://github.com/fmtjava/flutter_eyepetizer/blob/master/images/1911576051895_.pic.jpg" width="270"/>&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/fmtjava/flutter_eyepetizer/blob/master/images/2061576568586_.pic.jpg" width="270"/>&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/fmtjava/flutter_eyepetizer/blob/master/images/2051576568585_.pic.jpg" width="260"/>
</div>

<br/>

<div style="float:right">
  <img src="https://github.com/fmtjava/flutter_eyepetizer/blob/master/images/2041576568584_.pic.jpg" width="270"/>&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/fmtjava/flutter_eyepetizer/blob/master/images/2621584689733_.pic.jpg" width="270"/>&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/fmtjava/flutter_eyepetizer/blob/master/images/2611584689732_.pic.jpg" width="260"/>
</div>
<br/>

<div style="float:right">
  <img src="https://github.com/fmtjava/flutter_eyepetizer/blob/master/images/2601584689731_.pic.jpg" width="270"/>&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/fmtjava/flutter_eyepetizer/blob/master/images/2031576568583_.pic.jpg" width="270"/>&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/fmtjava/flutter_eyepetizer/blob/master/images/1981576565883_.pic.jpg" width="260"/>
</div>
<br/>

<div style="float:right">
  <img src="https://github.com/fmtjava/flutter_eyepetizer/blob/master/images/1961576565881_.pic.jpg" width="270"/>&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/fmtjava/flutter_eyepetizer/blob/master/images/2141576721487_.pic.jpg" width="270"/>&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/fmtjava/flutter_eyepetizer/blob/master/images/1941576565879_.pic.jpg" width="260"/>
</div>

<div style="float:right">
  <img src="https://github.com/fmtjava/flutter_eyepetizer/blob/master/images/2541583645461_.pic.jpg" width="270"/>&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/fmtjava/flutter_eyepetizer/blob/master/images/2531583645460_.pic.jpg" width="270"/>&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/fmtjava/flutter_eyepetizer/blob/master/images/2521583645458_.pic.jpg" width="260"/>
</div>

<div style="float:right">
  <img src="https://github.com/fmtjava/flutter_eyepetizer/blob/master/images/2081576569019_.pic.jpg" width="270"/>
  <img src="https://github.com/fmtjava/flutter_eyepetizer/blob/master/images/2071576569018_.pic.jpg" width="270"/>&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/fmtjava/flutter_eyepetizer/blob/master/images/2021576568582_.pic.jpg" width="270"/>&nbsp;&nbsp;&nbsp;
</div>

# 核心功能
<div>
  <img src="https://github.com/fmtjava/flutter_eyepetizer/blob/master/images/function.png"/>
</div>

# 核心技术点
<div>
  <img src="https://github.com/fmtjava/flutter_eyepetizer/blob/master/images/technology.png"/>
</div>

# 下载体验(Android版本) 
 - 点击[![](https://img.shields.io/badge/Download-apk-green.svg)](https://www.pgyer.com/nVnf) 下载(密码:123456)
 - 下方二维码下载(每日上限100次，如达到上限，还是 clone 源码吧！✧(≖ ◡ ≖✿))）<br/>
   <img src="https://www.pgyer.com/app/qrcode/nVnf"/>
 - ios请自行clone项目代码运行  
 # 更新日志
 ### v1.1.6
   * 专题列表页面添加列表滚动视频自动播放功能以及跳转视频播放页面无缝续播功能
 ### v1.1.5
   * 完善多状态视图，添加加载失败重试功能
 ### v1.1.4
   * 优化推荐列表,向下滑动图片加载异常，闪烁，卡顿，然后多向下滑动几屏会crash问题
 ### v1.1.3
   * Flutter升级适配v1.17.0(升级中遇到问题可借鉴:https://www.jianshu.com/p/171a9660e1f9)
 ### v1.1.2
   * 优化推荐小视频播放页面，根据视频的宽高设置播放器的宽高比，防止视频播放变形
 ### v1.1.1
   * 新增资讯列表页面、资讯详情页面
   * 封装分页模块代码，优化科大讯飞语音识别模块代码，后续持续完善中...
  ### v1.1.0
   * 新增专题列表页面、专题详情页面
   * 修复bug和优化代码，后续持续完善中...
  ### v1.0.9
   * 新增推荐页面、图片画廊显示页面、推荐小视频播放页面
   * 接入Get轻量级路由框架简化页面跳转，后续持续完善中...
  ### v1.0.8
   * 调整Chewie播放器样式，播放风格更加简洁
   * 页面跳转接入Hero动画提升用户体验
   * 使用flutter_slidable替换官方侧滑删除控件，使界面更加人性化
   * 增加视频搜索功能，支持关键字搜索、语音识别搜索，语音识别使用Fultter与Native通信，调用Native集成的科大讯飞语音识别功能，Native部分只实现了      Android部分(本人Android工程师一枚，敬请谅解，Ios的小伙伴可以自行实现Ios部分)后续持续完善中...
  ### v1.0.7
   * 接入Provider状态管理框架，重构部分页面的逻辑，完成界面与数据的分离，提升代码可读性
   * 调整整体UI样式，后续持续完善中...
  ### v1.0.6
   * 添加视频分享功能
   * 调整整体UI样式，后续持续完善中...
  ### v1.0.5
   * 修复进入查看个人主页加载中无法返回我的页面的bug
   * 修复列表图片在不同分辨率的手机上无法填充父容器bug，后续持续完善中...
  ### v1.0.4
   * 添加头像修改功能
   * 修复观看记录侧滑删除key值无法匹配以及子页面跳转后返回首页重新绘制bug，后续持续完善中...
  ### v1.0.3
   * 实现个人主页功能
   * 修复bug和优化代码，后续持续完善中...
  ### v1.0.2
   * 实现观看记录功能包含添加观看记录、观看记录列表展示、观看记录列表侧滑删除
   * 修复bug和优化代码，后续持续完善中...
 ### v1.0.1
   * 热门页面添加下拉刷新功能
   * 修复bug和优化代码，后续持续完善中...
 ### v1.0.0
   * 初始化项目，完成开眼视频App核心功能，目前实现首页、发现、热门、分类、我的、视频详情、视频播放等功能，后续持续完善中...
# Thanks
  - [cached_network_image](https://github.com/renefloor/flutter_cached_network_image) 图片缓存框架
  - [http](https://github.com/dart-lang/http) 网络请求框架
  - [fluttertoast](https://github.com/PonnamKarthik/FlutterToast) 吐司提示框架
  - [flutter_webview_plugin](https://github.com/fluttercommunity/flutter_webview_plugin) webView框架
  - [flutter_swiper](https://github.com/best-flutter/flutter_swiper) 轮播图框架
  - [flustars](https://github.com/Sky24n/flustars) 工具类集合
  - [pull_to_refresh](https://github.com/peng8350/flutter_pulltorefresh) 上拉刷新，下拉加载框架
  - [chewie](https://github.com/brianegan/chewie) 视频播放器框架
  - [shared_preferences](https://github.com/flutter/plugins) 本地缓存框架
  - [flutter_splash_screen](https://github.com/crazycodeboy/flutter_splash_screen) 启动白屏处理框架
  - [image_picker](https://github.com/flutter/plugins/tree/master/packages/image_picker) 相册取图/拍照框架
  - [share](https://github.com/flutter/plugins/tree/master/packages/share) 分享框架
  - [provider](https://github.com/rrousselGit/provider) 状态框架
  - [Get](https://github.com/jonataslaw/get) 路由框架
  
 # 关于我
  - WX：fmtjava
  - QQ：2694746499
  - Email：2694746499@qq.com
  - Github：https://github.com/fmtjava
  
 # 声明
  项目中的 API 均来自开眼视频，纯属学习交流使用，不得用于商业用途！
  
  # License 
  
  
Copyright (c) 2019 fmtjava

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
