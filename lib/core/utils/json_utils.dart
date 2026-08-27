class JsonUtils {
  static T enumFromString<T>(List<T> values, String? name, T fallback) {
    if (name == null) return fallback;
    return values.firstWhere(
      (v) => (v as Enum).name == name,
      orElse: () => fallback,
    );
  }

  static DateTime dateFromJson(dynamic value, {DateTime? fallback}) {
    if (value == null) return fallback ?? DateTime.now();
    return DateTime.parse(value as String);
  }
}