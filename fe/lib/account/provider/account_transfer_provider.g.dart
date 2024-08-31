// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_transfer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transferAccountHash() => r'131a1b42a727e6bc59a6009bf1479a99996bb67d';

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

/// 계좌 이체
///
/// Copied from [transferAccount].
@ProviderFor(transferAccount)
const transferAccountProvider = TransferAccountFamily();

/// 계좌 이체
///
/// Copied from [transferAccount].
class TransferAccountFamily extends Family<AsyncValue<BaseModel>> {
  /// 계좌 이체
  ///
  /// Copied from [transferAccount].
  const TransferAccountFamily();

  /// 계좌 이체
  ///
  /// Copied from [transferAccount].
  TransferAccountProvider call({
    required AccountTransferParam param,
  }) {
    return TransferAccountProvider(
      param: param,
    );
  }

  @override
  TransferAccountProvider getProviderOverride(
    covariant TransferAccountProvider provider,
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
  String? get name => r'transferAccountProvider';
}

/// 계좌 이체
///
/// Copied from [transferAccount].
class TransferAccountProvider extends AutoDisposeFutureProvider<BaseModel> {
  /// 계좌 이체
  ///
  /// Copied from [transferAccount].
  TransferAccountProvider({
    required AccountTransferParam param,
  }) : this._internal(
          (ref) => transferAccount(
            ref as TransferAccountRef,
            param: param,
          ),
          from: transferAccountProvider,
          name: r'transferAccountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$transferAccountHash,
          dependencies: TransferAccountFamily._dependencies,
          allTransitiveDependencies:
              TransferAccountFamily._allTransitiveDependencies,
          param: param,
        );

  TransferAccountProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.param,
  }) : super.internal();

  final AccountTransferParam param;

  @override
  Override overrideWith(
    FutureOr<BaseModel> Function(TransferAccountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TransferAccountProvider._internal(
        (ref) => create(ref as TransferAccountRef),
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
    return _TransferAccountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TransferAccountProvider && other.param == param;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, param.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TransferAccountRef on AutoDisposeFutureProviderRef<BaseModel> {
  /// The parameter `param` of this provider.
  AccountTransferParam get param;
}

class _TransferAccountProviderElement
    extends AutoDisposeFutureProviderElement<BaseModel>
    with TransferAccountRef {
  _TransferAccountProviderElement(super.provider);

  @override
  AccountTransferParam get param => (origin as TransferAccountProvider).param;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
