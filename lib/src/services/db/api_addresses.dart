class ProductAddresses {
  static final String product = '/products';
  static final String products = '/products/all';
}

class UserAddresses {
  static final String login = '/login';
  static final String register = '/register';
  static final String logout = '/logout';
}

String withId(String address, String id) {
  if(id == null)
    return address;
  return address + "/" + id;
}