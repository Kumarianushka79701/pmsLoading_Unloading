abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;

  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const LOADING_SCREEN = _Paths.LOADING_SCREEN;
  static const DATABSE_TABLE_SCREEN=_Paths.DATABSE_TABLE_SCREEN;
  static const FORGOT_ACCOUNT_PAGE= _Paths.FORGOT_ACCOUNT_PAGE;
}

abstract class _Paths {
  _Paths._();
static const SPLASH="/splash";
  static const HOME = "/home";
  static const LOGIN = "/login";
  static const LOADING_SCREEN = "/loading-screen";
  static const DATABSE_TABLE_SCREEN="/table";
static const String FORGOT_ACCOUNT_PAGE = '/forgot_account_page';
}
