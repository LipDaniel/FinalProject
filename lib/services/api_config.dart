class ApiConfig {
  static const baseUrl = 'http://192.168.1.54:8080/api';
  // static const baseUrl = 'http://172.16.1.18:8080/api';
  static const airPort = '/airport/gets';
  static const flight = '/flight/gets';
  static const flightinfo = '/flight/info';
  static const seatClass = '/ticketclass/gets';
  static const register = '/customer/register';
  static const login = '/customer/login';
  static const checkseat = '/ticket/check';
  static const insertbill = '/bill/insert';
  static const listtickets = '/bill/getbycustomermobile';
  static const updateProfile = '/customer/update';
  static const listNotification = '/noti/gets';
  static const deleteNotification = '/noti/changestatus';
}
