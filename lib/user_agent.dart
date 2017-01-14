library user_agent;

import 'package:r2d2/r2d2_common.dart' as r2;
import 'package:r2d2/r2d2_server.dart' as r2;

/**
 * Utils for device detection.
 */
class UserAgent extends r2.DeviceFace {
  bool _isChrome;
  bool _isOpera;
  bool _isIE;
  bool _isFirefox;
  bool _isWebKit;
  String _cachedCssPrefix;
  String _cachedPropertyPrefix;

  final String _userAgent;

  String userAgent() => _userAgent;

  UserAgent(this._userAgent, {Map headers: const {}}) {
    init(_userAgent, headers ?? {});
  }

  /// Determines if the user agent string contains the desired string. Case-insensitive.
  bool find(String needle) =>
      userAgent().toString().contains(needle.toLowerCase());

  bool mac() => find('Macintosh') || find('Mac OS X');

  bool get isSafari => find('Safari');

  /**
   * Determines if the current device is running Chrome.
   */
  bool get isChrome {
    if (_isChrome == null) {
      _isChrome = _userAgent.contains("Chrome", 0);
    }
    return _isChrome;
  }

  /**
   * Determines if the current device is running Opera.
   */
  bool get isOpera {
    if (_isOpera == null) {
      _isOpera = _userAgent.contains("Opera", 0);
    }
    return _isOpera;
  }

  /**
   * Determines if the current device is running Internet Explorer.
   */
  bool get isIE {
    if (_isIE == null) {
      _isIE = !isOpera && _userAgent.contains("Trident/", 0);
    }
    return _isIE;
  }

  /**
   * Determines if the current device is running Firefox.
   */
  bool get isFirefox {
    if (_isFirefox == null) {
      _isFirefox = _userAgent.contains("Firefox", 0);
    }
    return _isFirefox;
  }

  /**
   * Determines if the current device is running WebKit.
   */
  bool get isWebKit {
    if (_isWebKit == null) {
      _isWebKit = !isOpera && _userAgent.contains("WebKit", 0);
    }
    return _isWebKit;
  }

  /**
   * Gets the CSS property prefix for the current platform.
   */
  String get cssPrefix {
    String prefix = _cachedCssPrefix;
    if (prefix != null) return prefix;
    if (isFirefox) {
      prefix = '-moz-';
    } else if (isIE) {
      prefix = '-ms-';
    } else if (isOpera) {
      prefix = '-o-';
    } else {
      prefix = '-webkit-';
    }
    return _cachedCssPrefix = prefix;
  }

  /**
   * Prefix as used for JS property names.
   */
  String get propertyPrefix {
    String prefix = _cachedPropertyPrefix;
    if (prefix != null) return prefix;
    if (isFirefox) {
      prefix = 'moz';
    } else if (isIE) {
      prefix = 'ms';
    } else if (isOpera) {
      prefix = 'o';
    } else {
      prefix = 'webkit';
    }
    return _cachedPropertyPrefix = prefix;
  }
}
