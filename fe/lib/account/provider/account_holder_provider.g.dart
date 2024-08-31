// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_holder_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accountHolderHash() => r'c07aa513f5e7b31bdabb3a0641144d7025dc8bf4';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// 예금주 조회 (수시 입출금)
///
/// Copied from [accountHolder].
@ProviderFor(accountHolder)
const accountHolderProvider = AccountHolderFamily();

/// 예금주 조회 (수시 입출금)
///
/// Copied from [accountHolder].
class AccountHolderFamily extends Family<AsyncValue<BaseModel>> {
  /// 예금주 조회 (수시 입출금)
  ///
  /// Copied from [accountHolder].
  const AccountHolderFamily();

  /// 예금주 조회 (수시 입출금)
  ///
  /// Copied from [accountHolder].
  AccountHolderProvider call({
    required String accountNo,
  }) {
    return AccountHolderProvider(
      accountNo: accountNo,
    );
  }

  @override
  AccountHolderProvider getProviderOverride(
    covariant AccountHolderProvider provider,
  ) {
    return call(
      accountNo: provider.accountNo,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'accountHolderProvider';
}

/// 예금주 조회 (수시 입출금)
///
/// Copied from [accountHolder].
class AccountHolderProvider extends AutoDisposeFutureProvider<BaseModel> {
  /// 예금주 조회 (수시 입출금)
  ///
  /// Copied from [accountHolder].
  AccountHolderProvider({
    required String accountNo,
  }) : this._internal(
          (ref) => accountHolder(
            ref as AccountHolderRef,
            accountNo: accountNo,
          ),
          from: accountHolderProvider,
          name: r'accountHolderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$accountHolderHash,
          dependencies: AccountHolderFamily._dependencies,
          allTransitiveDependencies:
              AccountHolderFamily._allTransitiveDependencies,
          accountNo: accountNo,
        );

  AccountHolderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.accountNo,
  }) : super.internal();

  final String accountNo;

  @override
  Override overrideWith(
    FutureOr<BaseModel> Function(AccountHolderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AccountHolderProvider._internal(
        (ref) => create(ref as AccountHolderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        accountNo: accountNo,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BaseModel> createElement() {
    return _AccountHolderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AccountHolderProvider && other.accountNo == accountNo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountNo.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AccountHolderRef on AutoDisposeFutureProviderRef<BaseModel> {
  /// The parameter `accountNo` of this provider.
  String get accountNo;
}

class _AccountHolderProviderElement
    extends AutoDisposeFutureProviderElement<BaseModel> with AccountHolderRef {
  _AccountHolderProviderElement(super.provider);

  @override
  String get accountNo => (origin as AccountHolderProvider).accountNo;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
