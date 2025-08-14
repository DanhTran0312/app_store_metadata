// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'app_info.dart';

class AppInfoMapper extends ClassMapperBase<AppInfo> {
  AppInfoMapper._();

  static AppInfoMapper? _instance;
  static AppInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppInfoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AppInfo';

  static String _$id(AppInfo v) => v.id;
  static const Field<AppInfo, String> _f$id = Field('id', _$id);
  static String _$name(AppInfo v) => v.name;
  static const Field<AppInfo, String> _f$name = Field('name', _$name);
  static String _$developer(AppInfo v) => v.developer;
  static const Field<AppInfo, String> _f$developer = Field(
    'developer',
    _$developer,
  );
  static String? _$trackCensoredName(AppInfo v) => v.trackCensoredName;
  static const Field<AppInfo, String> _f$trackCensoredName = Field(
    'trackCensoredName',
    _$trackCensoredName,
    opt: true,
  );
  static String? _$bundleId(AppInfo v) => v.bundleId;
  static const Field<AppInfo, String> _f$bundleId = Field(
    'bundleId',
    _$bundleId,
    opt: true,
  );
  static String? _$kind(AppInfo v) => v.kind;
  static const Field<AppInfo, String> _f$kind = Field(
    'kind',
    _$kind,
    opt: true,
  );
  static String? _$wrapperType(AppInfo v) => v.wrapperType;
  static const Field<AppInfo, String> _f$wrapperType = Field(
    'wrapperType',
    _$wrapperType,
    opt: true,
  );
  static int? _$artistId(AppInfo v) => v.artistId;
  static const Field<AppInfo, int> _f$artistId = Field(
    'artistId',
    _$artistId,
    opt: true,
  );
  static String? _$artistViewUrl(AppInfo v) => v.artistViewUrl;
  static const Field<AppInfo, String> _f$artistViewUrl = Field(
    'artistViewUrl',
    _$artistViewUrl,
    opt: true,
  );
  static String? _$sellerName(AppInfo v) => v.sellerName;
  static const Field<AppInfo, String> _f$sellerName = Field(
    'sellerName',
    _$sellerName,
    opt: true,
  );
  static String? _$sellerUrl(AppInfo v) => v.sellerUrl;
  static const Field<AppInfo, String> _f$sellerUrl = Field(
    'sellerUrl',
    _$sellerUrl,
    opt: true,
  );
  static String? _$description(AppInfo v) => v.description;
  static const Field<AppInfo, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );
  static String? _$summary(AppInfo v) => v.summary;
  static const Field<AppInfo, String> _f$summary = Field(
    'summary',
    _$summary,
    opt: true,
  );
  static String? _$releaseNotes(AppInfo v) => v.releaseNotes;
  static const Field<AppInfo, String> _f$releaseNotes = Field(
    'releaseNotes',
    _$releaseNotes,
    opt: true,
  );
  static double? _$rating(AppInfo v) => v.rating;
  static const Field<AppInfo, double> _f$rating = Field(
    'rating',
    _$rating,
    opt: true,
  );
  static int? _$ratingCount(AppInfo v) => v.ratingCount;
  static const Field<AppInfo, int> _f$ratingCount = Field(
    'ratingCount',
    _$ratingCount,
    opt: true,
  );
  static double? _$currentVersionRating(AppInfo v) => v.currentVersionRating;
  static const Field<AppInfo, double> _f$currentVersionRating = Field(
    'currentVersionRating',
    _$currentVersionRating,
    opt: true,
  );
  static int? _$currentVersionRatingCount(AppInfo v) =>
      v.currentVersionRatingCount;
  static const Field<AppInfo, int> _f$currentVersionRatingCount = Field(
    'currentVersionRatingCount',
    _$currentVersionRatingCount,
    opt: true,
  );
  static String? _$price(AppInfo v) => v.price;
  static const Field<AppInfo, String> _f$price = Field(
    'price',
    _$price,
    opt: true,
  );
  static double? _$priceAmount(AppInfo v) => v.priceAmount;
  static const Field<AppInfo, double> _f$priceAmount = Field(
    'priceAmount',
    _$priceAmount,
    opt: true,
  );
  static String? _$currency(AppInfo v) => v.currency;
  static const Field<AppInfo, String> _f$currency = Field(
    'currency',
    _$currency,
    opt: true,
  );
  static String? _$iconUrl(AppInfo v) => v.iconUrl;
  static const Field<AppInfo, String> _f$iconUrl = Field(
    'iconUrl',
    _$iconUrl,
    opt: true,
  );
  static String? _$artworkUrl60(AppInfo v) => v.artworkUrl60;
  static const Field<AppInfo, String> _f$artworkUrl60 = Field(
    'artworkUrl60',
    _$artworkUrl60,
    opt: true,
  );
  static String? _$artworkUrl100(AppInfo v) => v.artworkUrl100;
  static const Field<AppInfo, String> _f$artworkUrl100 = Field(
    'artworkUrl100',
    _$artworkUrl100,
    opt: true,
  );
  static String? _$artworkUrl512(AppInfo v) => v.artworkUrl512;
  static const Field<AppInfo, String> _f$artworkUrl512 = Field(
    'artworkUrl512',
    _$artworkUrl512,
    opt: true,
  );
  static List<String> _$screenshots(AppInfo v) => v.screenshots;
  static const Field<AppInfo, List<String>> _f$screenshots = Field(
    'screenshots',
    _$screenshots,
    opt: true,
  );
  static List<String> _$ipadScreenshots(AppInfo v) => v.ipadScreenshots;
  static const Field<AppInfo, List<String>> _f$ipadScreenshots = Field(
    'ipadScreenshots',
    _$ipadScreenshots,
    opt: true,
  );
  static List<String> _$appletvScreenshots(AppInfo v) => v.appletvScreenshots;
  static const Field<AppInfo, List<String>> _f$appletvScreenshots = Field(
    'appletvScreenshots',
    _$appletvScreenshots,
    opt: true,
  );
  static String? _$category(AppInfo v) => v.category;
  static const Field<AppInfo, String> _f$category = Field(
    'category',
    _$category,
    opt: true,
  );
  static int? _$primaryGenreId(AppInfo v) => v.primaryGenreId;
  static const Field<AppInfo, int> _f$primaryGenreId = Field(
    'primaryGenreId',
    _$primaryGenreId,
    opt: true,
  );
  static List<String> _$genres(AppInfo v) => v.genres;
  static const Field<AppInfo, List<String>> _f$genres = Field(
    'genres',
    _$genres,
    opt: true,
  );
  static List<String> _$genreIds(AppInfo v) => v.genreIds;
  static const Field<AppInfo, List<String>> _f$genreIds = Field(
    'genreIds',
    _$genreIds,
    opt: true,
  );
  static String? _$contentRating(AppInfo v) => v.contentRating;
  static const Field<AppInfo, String> _f$contentRating = Field(
    'contentRating',
    _$contentRating,
    opt: true,
  );
  static String? _$contentAdvisoryRating(AppInfo v) => v.contentAdvisoryRating;
  static const Field<AppInfo, String> _f$contentAdvisoryRating = Field(
    'contentAdvisoryRating',
    _$contentAdvisoryRating,
    opt: true,
  );
  static List<String> _$advisories(AppInfo v) => v.advisories;
  static const Field<AppInfo, List<String>> _f$advisories = Field(
    'advisories',
    _$advisories,
    opt: true,
  );
  static String? _$version(AppInfo v) => v.version;
  static const Field<AppInfo, String> _f$version = Field(
    'version',
    _$version,
    opt: true,
  );
  static String? _$minimumOsVersion(AppInfo v) => v.minimumOsVersion;
  static const Field<AppInfo, String> _f$minimumOsVersion = Field(
    'minimumOsVersion',
    _$minimumOsVersion,
    opt: true,
  );
  static String? _$fileSizeBytes(AppInfo v) => v.fileSizeBytes;
  static const Field<AppInfo, String> _f$fileSizeBytes = Field(
    'fileSizeBytes',
    _$fileSizeBytes,
    opt: true,
  );
  static List<String> _$supportedDevices(AppInfo v) => v.supportedDevices;
  static const Field<AppInfo, List<String>> _f$supportedDevices = Field(
    'supportedDevices',
    _$supportedDevices,
    opt: true,
  );
  static List<String> _$features(AppInfo v) => v.features;
  static const Field<AppInfo, List<String>> _f$features = Field(
    'features',
    _$features,
    opt: true,
  );
  static List<String> _$languageCodes(AppInfo v) => v.languageCodes;
  static const Field<AppInfo, List<String>> _f$languageCodes = Field(
    'languageCodes',
    _$languageCodes,
    opt: true,
  );
  static String? _$releaseDate(AppInfo v) => v.releaseDate;
  static const Field<AppInfo, String> _f$releaseDate = Field(
    'releaseDate',
    _$releaseDate,
    opt: true,
  );
  static String? _$currentVersionReleaseDate(AppInfo v) =>
      v.currentVersionReleaseDate;
  static const Field<AppInfo, String> _f$currentVersionReleaseDate = Field(
    'currentVersionReleaseDate',
    _$currentVersionReleaseDate,
    opt: true,
  );
  static String? _$lastUpdated(AppInfo v) => v.lastUpdated;
  static const Field<AppInfo, String> _f$lastUpdated = Field(
    'lastUpdated',
    _$lastUpdated,
    opt: true,
  );
  static String? _$downloadUrl(AppInfo v) => v.downloadUrl;
  static const Field<AppInfo, String> _f$downloadUrl = Field(
    'downloadUrl',
    _$downloadUrl,
    opt: true,
  );
  static bool? _$isGameCenterEnabled(AppInfo v) => v.isGameCenterEnabled;
  static const Field<AppInfo, bool> _f$isGameCenterEnabled = Field(
    'isGameCenterEnabled',
    _$isGameCenterEnabled,
    opt: true,
  );
  static bool? _$isVppDeviceBasedLicensingEnabled(AppInfo v) =>
      v.isVppDeviceBasedLicensingEnabled;
  static const Field<AppInfo, bool> _f$isVppDeviceBasedLicensingEnabled = Field(
    'isVppDeviceBasedLicensingEnabled',
    _$isVppDeviceBasedLicensingEnabled,
    opt: true,
  );
  static int? _$downloads(AppInfo v) => v.downloads;
  static const Field<AppInfo, int> _f$downloads = Field(
    'downloads',
    _$downloads,
    opt: true,
  );
  static Map<String, dynamic>? _$additionalInfo(AppInfo v) => v.additionalInfo;
  static const Field<AppInfo, Map<String, dynamic>> _f$additionalInfo = Field(
    'additionalInfo',
    _$additionalInfo,
    opt: true,
  );
  static List<Object?> _$props(AppInfo v) => v.props;
  static const Field<AppInfo, List<Object?>> _f$props = Field(
    'props',
    _$props,
    mode: FieldMode.member,
  );

  @override
  final MappableFields<AppInfo> fields = const {
    #id: _f$id,
    #name: _f$name,
    #developer: _f$developer,
    #trackCensoredName: _f$trackCensoredName,
    #bundleId: _f$bundleId,
    #kind: _f$kind,
    #wrapperType: _f$wrapperType,
    #artistId: _f$artistId,
    #artistViewUrl: _f$artistViewUrl,
    #sellerName: _f$sellerName,
    #sellerUrl: _f$sellerUrl,
    #description: _f$description,
    #summary: _f$summary,
    #releaseNotes: _f$releaseNotes,
    #rating: _f$rating,
    #ratingCount: _f$ratingCount,
    #currentVersionRating: _f$currentVersionRating,
    #currentVersionRatingCount: _f$currentVersionRatingCount,
    #price: _f$price,
    #priceAmount: _f$priceAmount,
    #currency: _f$currency,
    #iconUrl: _f$iconUrl,
    #artworkUrl60: _f$artworkUrl60,
    #artworkUrl100: _f$artworkUrl100,
    #artworkUrl512: _f$artworkUrl512,
    #screenshots: _f$screenshots,
    #ipadScreenshots: _f$ipadScreenshots,
    #appletvScreenshots: _f$appletvScreenshots,
    #category: _f$category,
    #primaryGenreId: _f$primaryGenreId,
    #genres: _f$genres,
    #genreIds: _f$genreIds,
    #contentRating: _f$contentRating,
    #contentAdvisoryRating: _f$contentAdvisoryRating,
    #advisories: _f$advisories,
    #version: _f$version,
    #minimumOsVersion: _f$minimumOsVersion,
    #fileSizeBytes: _f$fileSizeBytes,
    #supportedDevices: _f$supportedDevices,
    #features: _f$features,
    #languageCodes: _f$languageCodes,
    #releaseDate: _f$releaseDate,
    #currentVersionReleaseDate: _f$currentVersionReleaseDate,
    #lastUpdated: _f$lastUpdated,
    #downloadUrl: _f$downloadUrl,
    #isGameCenterEnabled: _f$isGameCenterEnabled,
    #isVppDeviceBasedLicensingEnabled: _f$isVppDeviceBasedLicensingEnabled,
    #downloads: _f$downloads,
    #additionalInfo: _f$additionalInfo,
    #props: _f$props,
  };

  static AppInfo _instantiate(DecodingData data) {
    return AppInfo(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      developer: data.dec(_f$developer),
      trackCensoredName: data.dec(_f$trackCensoredName),
      bundleId: data.dec(_f$bundleId),
      kind: data.dec(_f$kind),
      wrapperType: data.dec(_f$wrapperType),
      artistId: data.dec(_f$artistId),
      artistViewUrl: data.dec(_f$artistViewUrl),
      sellerName: data.dec(_f$sellerName),
      sellerUrl: data.dec(_f$sellerUrl),
      description: data.dec(_f$description),
      summary: data.dec(_f$summary),
      releaseNotes: data.dec(_f$releaseNotes),
      rating: data.dec(_f$rating),
      ratingCount: data.dec(_f$ratingCount),
      currentVersionRating: data.dec(_f$currentVersionRating),
      currentVersionRatingCount: data.dec(_f$currentVersionRatingCount),
      price: data.dec(_f$price),
      priceAmount: data.dec(_f$priceAmount),
      currency: data.dec(_f$currency),
      iconUrl: data.dec(_f$iconUrl),
      artworkUrl60: data.dec(_f$artworkUrl60),
      artworkUrl100: data.dec(_f$artworkUrl100),
      artworkUrl512: data.dec(_f$artworkUrl512),
      screenshots: data.dec(_f$screenshots),
      ipadScreenshots: data.dec(_f$ipadScreenshots),
      appletvScreenshots: data.dec(_f$appletvScreenshots),
      category: data.dec(_f$category),
      primaryGenreId: data.dec(_f$primaryGenreId),
      genres: data.dec(_f$genres),
      genreIds: data.dec(_f$genreIds),
      contentRating: data.dec(_f$contentRating),
      contentAdvisoryRating: data.dec(_f$contentAdvisoryRating),
      advisories: data.dec(_f$advisories),
      version: data.dec(_f$version),
      minimumOsVersion: data.dec(_f$minimumOsVersion),
      fileSizeBytes: data.dec(_f$fileSizeBytes),
      supportedDevices: data.dec(_f$supportedDevices),
      features: data.dec(_f$features),
      languageCodes: data.dec(_f$languageCodes),
      releaseDate: data.dec(_f$releaseDate),
      currentVersionReleaseDate: data.dec(_f$currentVersionReleaseDate),
      lastUpdated: data.dec(_f$lastUpdated),
      downloadUrl: data.dec(_f$downloadUrl),
      isGameCenterEnabled: data.dec(_f$isGameCenterEnabled),
      isVppDeviceBasedLicensingEnabled: data.dec(
        _f$isVppDeviceBasedLicensingEnabled,
      ),
      downloads: data.dec(_f$downloads),
      additionalInfo: data.dec(_f$additionalInfo),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AppInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppInfo>(map);
  }

  static AppInfo fromJson(String json) {
    return ensureInitialized().decodeJson<AppInfo>(json);
  }
}

mixin AppInfoMappable {
  String toJson() {
    return AppInfoMapper.ensureInitialized().encodeJson<AppInfo>(
      this as AppInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return AppInfoMapper.ensureInitialized().encodeMap<AppInfo>(
      this as AppInfo,
    );
  }

  AppInfoCopyWith<AppInfo, AppInfo, AppInfo> get copyWith =>
      _AppInfoCopyWithImpl<AppInfo, AppInfo>(
        this as AppInfo,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AppInfoMapper.ensureInitialized().stringifyValue(this as AppInfo);
  }

  @override
  bool operator ==(Object other) {
    return AppInfoMapper.ensureInitialized().equalsValue(
      this as AppInfo,
      other,
    );
  }

  @override
  int get hashCode {
    return AppInfoMapper.ensureInitialized().hashValue(this as AppInfo);
  }
}

extension AppInfoValueCopy<$R, $Out> on ObjectCopyWith<$R, AppInfo, $Out> {
  AppInfoCopyWith<$R, AppInfo, $Out> get $asAppInfo =>
      $base.as((v, t, t2) => _AppInfoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AppInfoCopyWith<$R, $In extends AppInfo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get screenshots;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get ipadScreenshots;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get appletvScreenshots;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get genres;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get genreIds;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get advisories;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get supportedDevices;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get features;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get languageCodes;
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>?
  get additionalInfo;
  $R call({
    String? id,
    String? name,
    String? developer,
    String? trackCensoredName,
    String? bundleId,
    String? kind,
    String? wrapperType,
    int? artistId,
    String? artistViewUrl,
    String? sellerName,
    String? sellerUrl,
    String? description,
    String? summary,
    String? releaseNotes,
    double? rating,
    int? ratingCount,
    double? currentVersionRating,
    int? currentVersionRatingCount,
    String? price,
    double? priceAmount,
    String? currency,
    String? iconUrl,
    String? artworkUrl60,
    String? artworkUrl100,
    String? artworkUrl512,
    List<String>? screenshots,
    List<String>? ipadScreenshots,
    List<String>? appletvScreenshots,
    String? category,
    int? primaryGenreId,
    List<String>? genres,
    List<String>? genreIds,
    String? contentRating,
    String? contentAdvisoryRating,
    List<String>? advisories,
    String? version,
    String? minimumOsVersion,
    String? fileSizeBytes,
    List<String>? supportedDevices,
    List<String>? features,
    List<String>? languageCodes,
    String? releaseDate,
    String? currentVersionReleaseDate,
    String? lastUpdated,
    String? downloadUrl,
    bool? isGameCenterEnabled,
    bool? isVppDeviceBasedLicensingEnabled,
    int? downloads,
    Map<String, dynamic>? additionalInfo,
  });
  AppInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AppInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppInfo, $Out>
    implements AppInfoCopyWith<$R, AppInfo, $Out> {
  _AppInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppInfo> $mapper =
      AppInfoMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get screenshots => ListCopyWith(
    $value.screenshots,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(screenshots: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get ipadScreenshots => ListCopyWith(
    $value.ipadScreenshots,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(ipadScreenshots: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get appletvScreenshots => ListCopyWith(
    $value.appletvScreenshots,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(appletvScreenshots: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get genres =>
      ListCopyWith(
        $value.genres,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(genres: v),
      );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get genreIds =>
      ListCopyWith(
        $value.genreIds,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(genreIds: v),
      );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get advisories =>
      ListCopyWith(
        $value.advisories,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(advisories: v),
      );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get supportedDevices => ListCopyWith(
    $value.supportedDevices,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(supportedDevices: v),
  );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get features =>
      ListCopyWith(
        $value.features,
        (v, t) => ObjectCopyWith(v, $identity, t),
        (v) => call(features: v),
      );
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>
  get languageCodes => ListCopyWith(
    $value.languageCodes,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(languageCodes: v),
  );
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>?
  get additionalInfo => $value.additionalInfo != null
      ? MapCopyWith(
          $value.additionalInfo!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(additionalInfo: v),
        )
      : null;
  @override
  $R call({
    String? id,
    String? name,
    String? developer,
    Object? trackCensoredName = $none,
    Object? bundleId = $none,
    Object? kind = $none,
    Object? wrapperType = $none,
    Object? artistId = $none,
    Object? artistViewUrl = $none,
    Object? sellerName = $none,
    Object? sellerUrl = $none,
    Object? description = $none,
    Object? summary = $none,
    Object? releaseNotes = $none,
    Object? rating = $none,
    Object? ratingCount = $none,
    Object? currentVersionRating = $none,
    Object? currentVersionRatingCount = $none,
    Object? price = $none,
    Object? priceAmount = $none,
    Object? currency = $none,
    Object? iconUrl = $none,
    Object? artworkUrl60 = $none,
    Object? artworkUrl100 = $none,
    Object? artworkUrl512 = $none,
    Object? screenshots = $none,
    Object? ipadScreenshots = $none,
    Object? appletvScreenshots = $none,
    Object? category = $none,
    Object? primaryGenreId = $none,
    Object? genres = $none,
    Object? genreIds = $none,
    Object? contentRating = $none,
    Object? contentAdvisoryRating = $none,
    Object? advisories = $none,
    Object? version = $none,
    Object? minimumOsVersion = $none,
    Object? fileSizeBytes = $none,
    Object? supportedDevices = $none,
    Object? features = $none,
    Object? languageCodes = $none,
    Object? releaseDate = $none,
    Object? currentVersionReleaseDate = $none,
    Object? lastUpdated = $none,
    Object? downloadUrl = $none,
    Object? isGameCenterEnabled = $none,
    Object? isVppDeviceBasedLicensingEnabled = $none,
    Object? downloads = $none,
    Object? additionalInfo = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (developer != null) #developer: developer,
      if (trackCensoredName != $none) #trackCensoredName: trackCensoredName,
      if (bundleId != $none) #bundleId: bundleId,
      if (kind != $none) #kind: kind,
      if (wrapperType != $none) #wrapperType: wrapperType,
      if (artistId != $none) #artistId: artistId,
      if (artistViewUrl != $none) #artistViewUrl: artistViewUrl,
      if (sellerName != $none) #sellerName: sellerName,
      if (sellerUrl != $none) #sellerUrl: sellerUrl,
      if (description != $none) #description: description,
      if (summary != $none) #summary: summary,
      if (releaseNotes != $none) #releaseNotes: releaseNotes,
      if (rating != $none) #rating: rating,
      if (ratingCount != $none) #ratingCount: ratingCount,
      if (currentVersionRating != $none)
        #currentVersionRating: currentVersionRating,
      if (currentVersionRatingCount != $none)
        #currentVersionRatingCount: currentVersionRatingCount,
      if (price != $none) #price: price,
      if (priceAmount != $none) #priceAmount: priceAmount,
      if (currency != $none) #currency: currency,
      if (iconUrl != $none) #iconUrl: iconUrl,
      if (artworkUrl60 != $none) #artworkUrl60: artworkUrl60,
      if (artworkUrl100 != $none) #artworkUrl100: artworkUrl100,
      if (artworkUrl512 != $none) #artworkUrl512: artworkUrl512,
      if (screenshots != $none) #screenshots: screenshots,
      if (ipadScreenshots != $none) #ipadScreenshots: ipadScreenshots,
      if (appletvScreenshots != $none) #appletvScreenshots: appletvScreenshots,
      if (category != $none) #category: category,
      if (primaryGenreId != $none) #primaryGenreId: primaryGenreId,
      if (genres != $none) #genres: genres,
      if (genreIds != $none) #genreIds: genreIds,
      if (contentRating != $none) #contentRating: contentRating,
      if (contentAdvisoryRating != $none)
        #contentAdvisoryRating: contentAdvisoryRating,
      if (advisories != $none) #advisories: advisories,
      if (version != $none) #version: version,
      if (minimumOsVersion != $none) #minimumOsVersion: minimumOsVersion,
      if (fileSizeBytes != $none) #fileSizeBytes: fileSizeBytes,
      if (supportedDevices != $none) #supportedDevices: supportedDevices,
      if (features != $none) #features: features,
      if (languageCodes != $none) #languageCodes: languageCodes,
      if (releaseDate != $none) #releaseDate: releaseDate,
      if (currentVersionReleaseDate != $none)
        #currentVersionReleaseDate: currentVersionReleaseDate,
      if (lastUpdated != $none) #lastUpdated: lastUpdated,
      if (downloadUrl != $none) #downloadUrl: downloadUrl,
      if (isGameCenterEnabled != $none)
        #isGameCenterEnabled: isGameCenterEnabled,
      if (isVppDeviceBasedLicensingEnabled != $none)
        #isVppDeviceBasedLicensingEnabled: isVppDeviceBasedLicensingEnabled,
      if (downloads != $none) #downloads: downloads,
      if (additionalInfo != $none) #additionalInfo: additionalInfo,
    }),
  );
  @override
  AppInfo $make(CopyWithData data) => AppInfo(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    developer: data.get(#developer, or: $value.developer),
    trackCensoredName: data.get(
      #trackCensoredName,
      or: $value.trackCensoredName,
    ),
    bundleId: data.get(#bundleId, or: $value.bundleId),
    kind: data.get(#kind, or: $value.kind),
    wrapperType: data.get(#wrapperType, or: $value.wrapperType),
    artistId: data.get(#artistId, or: $value.artistId),
    artistViewUrl: data.get(#artistViewUrl, or: $value.artistViewUrl),
    sellerName: data.get(#sellerName, or: $value.sellerName),
    sellerUrl: data.get(#sellerUrl, or: $value.sellerUrl),
    description: data.get(#description, or: $value.description),
    summary: data.get(#summary, or: $value.summary),
    releaseNotes: data.get(#releaseNotes, or: $value.releaseNotes),
    rating: data.get(#rating, or: $value.rating),
    ratingCount: data.get(#ratingCount, or: $value.ratingCount),
    currentVersionRating: data.get(
      #currentVersionRating,
      or: $value.currentVersionRating,
    ),
    currentVersionRatingCount: data.get(
      #currentVersionRatingCount,
      or: $value.currentVersionRatingCount,
    ),
    price: data.get(#price, or: $value.price),
    priceAmount: data.get(#priceAmount, or: $value.priceAmount),
    currency: data.get(#currency, or: $value.currency),
    iconUrl: data.get(#iconUrl, or: $value.iconUrl),
    artworkUrl60: data.get(#artworkUrl60, or: $value.artworkUrl60),
    artworkUrl100: data.get(#artworkUrl100, or: $value.artworkUrl100),
    artworkUrl512: data.get(#artworkUrl512, or: $value.artworkUrl512),
    screenshots: data.get(#screenshots, or: $value.screenshots),
    ipadScreenshots: data.get(#ipadScreenshots, or: $value.ipadScreenshots),
    appletvScreenshots: data.get(
      #appletvScreenshots,
      or: $value.appletvScreenshots,
    ),
    category: data.get(#category, or: $value.category),
    primaryGenreId: data.get(#primaryGenreId, or: $value.primaryGenreId),
    genres: data.get(#genres, or: $value.genres),
    genreIds: data.get(#genreIds, or: $value.genreIds),
    contentRating: data.get(#contentRating, or: $value.contentRating),
    contentAdvisoryRating: data.get(
      #contentAdvisoryRating,
      or: $value.contentAdvisoryRating,
    ),
    advisories: data.get(#advisories, or: $value.advisories),
    version: data.get(#version, or: $value.version),
    minimumOsVersion: data.get(#minimumOsVersion, or: $value.minimumOsVersion),
    fileSizeBytes: data.get(#fileSizeBytes, or: $value.fileSizeBytes),
    supportedDevices: data.get(#supportedDevices, or: $value.supportedDevices),
    features: data.get(#features, or: $value.features),
    languageCodes: data.get(#languageCodes, or: $value.languageCodes),
    releaseDate: data.get(#releaseDate, or: $value.releaseDate),
    currentVersionReleaseDate: data.get(
      #currentVersionReleaseDate,
      or: $value.currentVersionReleaseDate,
    ),
    lastUpdated: data.get(#lastUpdated, or: $value.lastUpdated),
    downloadUrl: data.get(#downloadUrl, or: $value.downloadUrl),
    isGameCenterEnabled: data.get(
      #isGameCenterEnabled,
      or: $value.isGameCenterEnabled,
    ),
    isVppDeviceBasedLicensingEnabled: data.get(
      #isVppDeviceBasedLicensingEnabled,
      or: $value.isVppDeviceBasedLicensingEnabled,
    ),
    downloads: data.get(#downloads, or: $value.downloads),
    additionalInfo: data.get(#additionalInfo, or: $value.additionalInfo),
  );

  @override
  AppInfoCopyWith<$R2, AppInfo, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AppInfoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

