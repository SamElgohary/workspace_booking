// lib/assets.dart

class Assets {
  Assets._(); // This prevents instantiation of the Assets class

  static const _Images images = _Images();
  static const _Icons icons = _Icons();
}

class _Images {
  const _Images();

  final String logo = 'assets/images/logo.png';
  final String splashLogo = 'assets/images/splash.png';
}

class _Icons {
  const _Icons();

  final String scanCard = 'assets/icons/id.png';
}

