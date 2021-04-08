abstract class NamedNavigator {
  Future push(String routeName, {dynamic arguments, bool replace = false});

  void pop({dynamic result});
}

class Routes {
  static const INITIAL_PAGE = "INITIAL_PAGE_ROUTER";
  static const DEVICES_LIST = "DEVICES_LIST_ROUTER";
  static const DEVICE_DETAILS = "DEVICE_DETAILS_ROUTER";
}
