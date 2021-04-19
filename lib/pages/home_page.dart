import 'dart:math';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter_study/widgets/pannel/video_pannel.dart';
import 'package:flutter_study/widgets/tv_list.dart';
import 'package:wakelock/wakelock.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FijkPlayer player = FijkPlayer();

  // 手势控件
  TapGestureRecognizer _tapGesture;

  String url = 'http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8';

  List<Map<String, String>> videoUrl = [
    {'title': 'CCTV1', 'url': 'http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8'},
    {'title': 'CCTV2', 'url': 'http://ivi.bupt.edu.cn/hls/cctv2hd.m3u8'},
    {'title': 'CCTV3', 'url': 'http://ivi.bupt.edu.cn/hls/cctv3hd.m3u8'},
    {'title': '北京卫视', 'url': 'http://ivi.bupt.edu.cn/hls/btv1hd.m3u8'},
    {
      "title": "国寿新青年 孙君早",
      "url":
          "https://oss.jxbrty.com/lejian/web-app/app/assets/activity/ai-cloud-interview/广东中山孙君早.mp4"
    },
  ];

  @override
  void initState() {
    initializePlayer();
    _tapGesture = TapGestureRecognizer();
    player?.addListener(() {
      if (player.state == FijkState.paused) {
        Wakelock.disable();
        print(
            '=================================================================暂停了');
      } else if (player.state == FijkState.started) {
        print(
            '=================================================================开始了');
        Wakelock.enable();
      }
      setState(() {});
    });
    Wakelock.enable();
    super.initState();
  }

  @override
  void dispose() {
    player.release();
    Wakelock.disable();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    await player.setDataSource(url, autoPlay: true);

    FijkVolume.setUIMode(FijkVolume.alwaysShowUI);
    setState(() {});
  }

  /// 更改视频源
  void setUrl(String url) async {
    // 重置播放器
    await player.reset();
    // 重置视频源
    await player.setDataSource(url, autoPlay: true);

    setState(() {});
  }

  Widget buildGrid() {
    List<Widget> buttons = []; //先建一个数组用于存放循环生成的widget
    Widget content; //单独一个widget组件，用于返回需要生成的内容widget
    for (var item in videoUrl) {
      buttons.add(TextButton(
          onPressed: () {
            print(item['url']);
            setUrl(item['url']);
          },
          child: Text(item['title'])));
    }
    content = new Column(children: buttons);
    return content;
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQueryData.fromWindow(window));
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Video demo'),
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Center(
              child: player.isPlayable()
                  ? FijkView(
                      width: MediaQuery.of(context).size.width,
                      height: 260.00,
                      player: player,
                      panelBuilder: (FijkPlayer player,
                          FijkData data,
                          BuildContext context,
                          Size viewSize,
                          Rect texturePos) {
                        return CustomFijkPanel(
                            player: player,
                            // 传递 context 用于左上角返回箭头关闭当前页面，不要传递错误 context，
                            // 如果要点击箭头关闭当前的页面，那必须传递当前页面的根 context
                            buildContext: context,
                            viewSize: viewSize,
                            texturePos: texturePos,
                            // 是否显示顶部，如果要显示顶部标题栏 + 返回键，那么就传递 true
                            showTopCon: true,
                            // 标题 当前页面顶部的标题部分
                            playerTitle: "标题");
                      },
                      color: Colors.black,
                      fit: FijkFit.ar16_9)
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: 260.00,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black26)),
                      child: Center(
                        child: Text('加载中...'),
                      ),
                    ),
            ),
            buildGrid(),
            // Container(
            //     height: MediaQuery.of(context).size.height - 260 - 20,
            //     // MediaQuery.of(context).padding.top,
            //     color: Colors.white,
            //     child: tvList())
          ],
        ),
      ),
    );
  }
}
