/// Utility class for URL detection and parsing
class UrlUtils {
  /// Regular expression to detect URLs in text
  static final RegExp _urlRegex = RegExp(
    r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
    caseSensitive: false,
  );

  /// Check if text contains a URL
  static bool containsUrl(String text) {
    return _urlRegex.hasMatch(text);
  }

  /// Extract first URL from text
  static String? extractFirstUrl(String text) {
    final match = _urlRegex.firstMatch(text);
    return match?.group(0);
  }

  /// Extract all URLs from text
  static List<String> extractAllUrls(String text) {
    return _urlRegex.allMatches(text).map((match) => match.group(0)!).toList();
  }

  /// Check if text is ONLY a URL (no other text)
  static bool isOnlyUrl(String text) {
    final trimmed = text.trim();
    final url = extractFirstUrl(trimmed);
    return url != null && url == trimmed;
  }

  /// Check if URL is valid
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }
}
