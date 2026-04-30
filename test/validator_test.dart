import 'package:flutter_test/flutter_test.dart';
import 'package:v_and_v_assignment/validator.dart'; // <--- استبدل هذا باسم مشروعك

void main() {
  // الـ Setup: يُنفذ قبل كل حالة اختبار
  setUp(() {
    print("Pre-test setup: initializing...");
  });

  // الـ Teardown: يُنفذ بعد كل حالة اختبار
  tearDown(() {
    print("Post-test teardown: cleaning up...");
  });

  group('Signup Logic Verification (15 Cases)', () {
    // --- اختبارات الاسم (Names) ---
    test('1. Valid Name', () => expect(Validator.validateName("Osama"), null));
    test(
      '2. Empty Name (EP - Invalid)',
      () => expect(Validator.validateName(""), "Required"),
    );
    test(
      '3. Single Char Name (Boundary \$x < 2\$)',
      () => expect(Validator.validateName("A"), "Short"),
    );
    test(
      '4. Name with Numbers (EP)',
      () => expect(Validator.validateName("Osama123"), "No Numbers"),
    );

    // --- اختبارات الإيميل (Email) ---
    test(
      '5. Correct Email Format',
      () => expect(Validator.validateEmail("test@hku.edu.tr"), true),
    );
    test(
      '6. Email missing @',
      () => expect(Validator.validateEmail("osama.gmail.com"), false),
    );
    test(
      '7. Email missing dot',
      () => expect(Validator.validateEmail("osama@gmail"), false),
    );
    test('8. Empty Email', () => expect(Validator.validateEmail(""), false));

    // --- اختبارات العمر (DOB - Age) تم تعديلها لتكون أدق ---
    test('9. Age exactly 18 (BVA - Boundary)', () {
      final today = DateTime.now();
      // تاريخ ميلاد قبل 18 سنة بالضبط من اليوم
      final date18 = DateTime(today.year - 18, today.month, today.day);
      expect(Validator.isAdult(date18), true);
    });

    test('10. Age exactly 17 (BVA - Boundary)', () {
      final today = DateTime.now();
      // تاريخ ميلاد قبل 17 سنة من اليوم (يوم واحد بعد الـ 18 لضمان الفشل)
      final date17 = DateTime(
        today.year - 17,
        today.month,
        today.day,
      ).add(const Duration(days: 1));
      expect(Validator.isAdult(date17), false);
    });

    test('11. Birth date in future (EP)', () {
      expect(Validator.isAdult(DateTime(2030, 1, 1)), false);
    });

    // --- اختبارات كلمة المرور (Password) ---
    test(
      '12. Password 8 chars (BVA)',
      () => expect(Validator.validatePassword("12345678", "12345678"), true),
    );
    test(
      '13. Password 7 chars (BVA)',
      () => expect(Validator.validatePassword("1234567", "1234567"), false),
    );
    test(
      '14. Passwords mismatch (Logic)',
      () => expect(Validator.validatePassword("12345678", "87654321"), false),
    );
    test(
      '15. Empty password',
      () => expect(Validator.validatePassword("", ""), false),
    );
  });
}
// Final check for submission