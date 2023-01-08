class Validation
{
  bool isValidEmail(String mailid) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(mailid);
  }


  bool  isValidName(name){
    final nameRegExp = new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(name);
  }
  
  bool  isValidPassword(pass){
    final passwordRegExp =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(pass);
  }
  
  bool  isNotNull(nullval){
    return nullval!=null;
  }
  
  bool  isValidPhone(phone){
    final phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
    return phoneRegExp.hasMatch(phone);
    }

  bool  isValidfloat(floating){
    final floatRegExp = RegExp(r"[-9]*\.?[0-9]*");
    return floatRegExp.hasMatch(floating);
    }
}