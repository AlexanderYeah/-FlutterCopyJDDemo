// 适配的库
import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapter {
  // 初始化
  static init(context) {
    ScreenUtil.init(context, designSize: const Size(750, 1334));
  }

  // 设置高度
  static height(double value) {
    return ScreenUtil().setHeight(value);
  }

  // 设置宽度
  static width(double value) {
    return ScreenUtil().setWidth(value);
  }

  // 获取屏幕宽度
  static getScreenWidth() {
    return ScreenUtil().screenWidth;
  }

  // 获取屏幕高度
  static getScreenHeight() {
    return ScreenUtil().screenHeight;
  }

  // 适配字体大小
  static fontSize(double value) {
    return ScreenUtil().setSp(value);
  }
}
