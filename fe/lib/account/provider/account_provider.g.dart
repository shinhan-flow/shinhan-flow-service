// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createAccountHash() => r'212d891de3db638469615b1b7c40b54d04bc7946';

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

/// 계좌 생성 (수시 입출금)
///
/// Copied from [createAccount].
@ProviderFor(createAccount)
const createAccountProvider = CreateAccountFamily();

/// 계좌 생성 (수시 입출금)
///
/// Copied from [createAccount].
class CreateAccountFamily extends Family<AsyncValue<BaseModel>> {
  /// 계좌 생성 (수시 입출금)
  ///
  /// Copied from [createAccount].
  const CreateAccountFamily();

  /// 계좌 생성 (수시 입출금)
  ///
  /// Copied from [createAccount].
  CreateAccountProvider call({
    required AccountCreateParam param,
  }) {
    return CreateAccountProvider(
      param: param,
    );
  }

  @override
  CreateAccountProvider getProviderOverride(
    covariant CreateAccountProvider provider,
  ) {
    return call(
      param: provider.param,
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
  String? get name => r'createAccountProvider';
}

/// 계좌 생성 (수시 입출금)
///
/// Copied from [createAccount].
class CreateAccountProvider extends AutoDisposeFutureProvider<BaseModel> {
  /// 계좌 생성 (수시 입출금)
  ///
  /// Copied from [createAccount].
  CreateAccountProvider({
    required AccountCreateParam param,
  }) : this._internal(
          (ref) => createAccount(
            ref as CreateAccountRef,
            param: param,
          ),
          from: createAccountProvider,
          name: r'createAccountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createAccountHash,
          dependencies: CreateAccountFamily._dependencies,
          allTransitiveDependencies:
              CreateAccountFamily._allTransitiveDependencies,
          param: param,
        );

  CreateAccountProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.param,
  }) : super.internal();

  final AccountCreateParam param;

  @override
  Override overrideWith(
    FutureOr<BaseModel> Function(CreateAccountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateAccountProvider._internal(
        (ref) => create(ref as CreateAccountRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        param: param,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BaseModel> createElement() {
    return _CreateAccountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateAccountProvider && other.param == param;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, param.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CreateAccountRef on AutoDisposeFutureProviderRef<BaseModel> {
  /// The parameter `param` of this provider.
  AccountCreateParam get param;
}

class _CreateAccountProviderElement
    extends AutoDisposeFutureProviderElement<BaseModel> with CreateAccountRef {
  _CreateAccountProviderElement(super.provider);

  @override
  AccountCreateParam get param => (origin as CreateAccountProvider).param;
}

String _$accountHash() => r'dbc067244987045d4dbbab015707a046a0361d57';

abstract class _$Account extends BuildlessAutoDisposeNotifier<BaseModel> {
  late final String accountNo;

  BaseModel build({
    required String accountNo,
  });
}

/// 본인 계좌 목록 단건 조회 (수시 입출금)
///
/// Copied from [Account].
@ProviderFor(Account)
const accountProvider = AccountFamily();

/// 본인 계좌 목록 단건 조회 (수시 입출금)
///
/// Copied from [Account].
class AccountFamily extends Family<BaseModel> {
  /// 본인 계좌 목록 단건 조회 (수시 입출금)
  ///
  /// Copied from [Account].
  const AccountFamily();

  /// 본인 계좌 목록 단건 조회 (수시 입출금)
  ///
  /// Copied from [Account].
  AccountProvider call({
    required String accountNo,
  }) {
    return AccountProvider(
      accountNo: accountNo,
    );
  }

  @override
  AccountProvider getProviderOverride(
    covariant AccountProvider provider,
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
  String? get name => r'accountProvider';
}

/// 본인 계좌 목록 단건 조회 (수시 입출금)
///
/// Copied from [Account].
class AccountProvider
    extends AutoDisposeNotifierProviderImpl<Account, BaseModel> {
  /// 본인 계좌 목록 단건 조회 (수시 입출금)
  ///
  /// Copied from [Account].
  AccountProvider({
    required String accountNo,
  }) : this._internal(
          () => Account()..accountNo = accountNo,
          from: accountProvider,
          name: r'accountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$accountHash,
          dependencies: AccountFamily._dependencies,
          allTransitiveDependencies: AccountFamily._allTransitiveDependencies,
          accountNo: accountNo,
        );

  AccountProvider._internal(
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
  BaseModel runNotifierBuild(
    covariant Account notifier,
  ) {
    return notifier.build(
      accountNo: accountNo,
    );
  }

  @override
  Override overrideWith(Account Function() create) {
    return ProviderOverride(
      origin: this,
      override: AccountProvider._internal(
        () => create()..accountNo = accountNo,
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
  AutoDisposeNotifierProviderElement<Account, BaseModel> createElement() {
    return _AccountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AccountProvider && other.accountNo == accountNo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountNo.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AccountRef on AutoDisposeNotifierProviderRef<BaseModel> {
  /// The parameter `accountNo` of this provider.
  String get accountNo;
}

class _AccountProviderElement
    extends AutoDisposeNotifierProviderElement<Account, BaseModel>
    with AccountRef {
  _AccountProviderElement(super.provider);

  @override
  String get accountNo => (origin as AccountProvider).accountNo;
}

String _$accountListHash() => r'b4df4a3a5f19e49172290ae2eebb696b1133ed8d';

/// 본인 계좌 목록 전체 조회 (수시 입출금)
///
/// Copied from [AccountList].
@ProviderFor(AccountList)
final accountListProvider =
    AutoDisposeNotifierProvider<AccountList, BaseModel>.internal(
  AccountList.new,
  name: r'accountListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$accountListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AccountList = AutoDisposeNotifier<BaseModel>;
String _$accountBalanceHash() => r'0dad0c18b4b290ddbcb74147e6a79938f53664bd';

abstract class _$AccountBalance
    extends BuildlessAutoDisposeNotifier<BaseModel> {
  late final String accountNo;

  BaseModel build({
    required String accountNo,
  });
}

/// 계좌 잔액 조회 (수시 입출금)
///
/// Copied from [AccountBalance].
@ProviderFor(AccountBalance)
const accountBalanceProvider = AccountBalanceFamily();

/// 계좌 잔액 조회 (수시 입출금)
///
/// Copied from [AccountBalance].
class AccountBalanceFamily extends Family<BaseModel> {
  /// 계좌 잔액 조회 (수시 입출금)
  ///
  /// Copied from [AccountBalance].
  const AccountBalanceFamily();

  /// 계좌 잔액 조회 (수시 입출금)
  ///
  /// Copied from [AccountBalance].
  AccountBalanceProvider call({
    required String accountNo,
  }) {
    return AccountBalanceProvider(
      accountNo: accountNo,
    );
  }

  @override
  AccountBalanceProvider getProviderOverride(
    covariant AccountBalanceProvider provider,
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
  String? get name => r'accountBalanceProvider';
}

/// 계좌 잔액 조회 (수시 입출금)
///
/// Copied from [AccountBalance].
class AccountBalanceProvider
    extends AutoDisposeNotifierProviderImpl<AccountBalance, BaseModel> {
  /// 계좌 잔액 조회 (수시 입출금)
  ///
  /// Copied from [AccountBalance].
  AccountBalanceProvider({
    required String accountNo,
  }) : this._internal(
          () => AccountBalance()..accountNo = accountNo,
          from: accountBalanceProvider,
          name: r'accountBalanceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$accountBalanceHash,
          dependencies: AccountBalanceFamily._dependencies,
          allTransitiveDependencies:
              AccountBalanceFamily._allTransitiveDependencies,
          accountNo: accountNo,
        );

  AccountBalanceProvider._internal(
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
  BaseModel runNotifierBuild(
    covariant AccountBalance notifier,
  ) {
    return notifier.build(
      accountNo: accountNo,
    );
  }

  @override
  Override overrideWith(AccountBalance Function() create) {
    return ProviderOverride(
      origin: this,
      override: AccountBalanceProvider._internal(
        () => create()..accountNo = accountNo,
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
  AutoDisposeNotifierProviderElement<AccountBalance, BaseModel>
      createElement() {
    return _AccountBalanceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AccountBalanceProvider && other.accountNo == accountNo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountNo.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AccountBalanceRef on AutoDisposeNotifierProviderRef<BaseModel> {
  /// The parameter `accountNo` of this provider.
  String get accountNo;
}

class _AccountBalanceProviderElement
    extends AutoDisposeNotifierProviderElement<AccountBalance, BaseModel>
    with AccountBalanceRef {
  _AccountBalanceProviderElement(super.provider);

  @override
  String get accountNo => (origin as AccountBalanceProvider).accountNo;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
