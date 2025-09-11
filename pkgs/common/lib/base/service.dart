import 'dart:collection';
import 'dart:core';

///对各个模块暴露的服务，协助功能抽离
class AppService {
  static final AppService _singleton = AppService._internal();

  factory AppService() {
    return _singleton;
  }

  AppService._internal();

  final HashMap<String, ModuleFun> _funMap = HashMap();

  ///调用某个功能
  ///[moduleName]模块名 [rp]参数
  ///[funName]模块功能名 [rp]参数
  Future<ServiceResult> run(
      String moduleName, String funName, {Map<String, dynamic>? rp}) async {
    final fun = _funMap[moduleName];
    if (fun != null) {
      return fun(funName, rp);
    }

    return ServiceResult();
  }

  ///添加模块的功能
  ///[moduleName]模块名 [fun]功能方法
  void addModuleFun(String moduleName, ModuleFun fun) {
    if (_funMap.containsKey(moduleName)) {
      _funMap.remove(moduleName);
    }
    _funMap[moduleName] = fun;
  }
}

typedef ModuleFun = Future<ServiceResult> Function(
    String funName, Map<String, dynamic>? rp);

class ServiceResult {
  bool isSuc = false;
  dynamic result;

  ServiceResult();
}
