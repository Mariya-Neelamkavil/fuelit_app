class Validation
{
  bool isValidEmail(String mailid) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(mailid);
  }

  bool  isValidName(name){
    final nameRegExp =  RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(name);
  }

  bool  isValidPassword(pass){
    final passwordRegExp   = RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");
    return passwordRegExp.hasMatch(pass);
  }

  bool isNotNull(String value){
    return value.isEmpty;
  }

  bool  isValidPhone(phone){
    final phoneRegExp = RegExp(r"^\+?[0-9]{10}$");
    return phoneRegExp.hasMatch(phone);
  }
}