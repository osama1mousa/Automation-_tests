class Validator {
  // 1. التحقق من الاسم: لا يقل عن 2 ولا يحتوي أرقام
  static String? validateName(String name) {
    if (name.isEmpty) return "Required";
    if (name.length < 2) return "Short";
    if (RegExp(r'[0-9]').hasMatch(name)) return "No Numbers";
    return null;
  }

  // 2. التحقق من الإيميل
  static bool validateEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // 3. التحقق من السن: يجب أن يكون 18 أو أكثر
  static bool isAdult(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    
    // تصحيح دقيق للعمر بناءً على الشهر واليوم
    if (today.month < birthDate.month || 
       (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age >= 18;
  }

  // 4. التحقق من كلمة المرور وتطابقها
  static bool validatePassword(String p1, String p2) {
    if (p1.length < 8) return false;
    return p1 == p2;
  }
}