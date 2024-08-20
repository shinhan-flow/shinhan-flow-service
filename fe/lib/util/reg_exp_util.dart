class RegExpUtil {
  static bool email(String input) {
    RegExp regex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(input);
  }

  static bool validForm(String min_invitation, String max_invitation) {
    if (min_invitation.isNotEmpty && max_invitation.isNotEmpty) {
      if (int.parse(min_invitation) >= int.parse(max_invitation)) {
        return false;
      } else if (int.parse(max_invitation) <= 0) {
        return false;
      }
    }
    return true;
  }
}
