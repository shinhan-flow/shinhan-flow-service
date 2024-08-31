// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flow_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createFlowHash() => r'72b033febf1924135340b2cb9a90526a4f4e9d40';

/// See also [createFlow].
@ProviderFor(createFlow)
final createFlowProvider = AutoDisposeFutureProvider<BaseModel>.internal(
  createFlow,
  name: r'createFlowProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$createFlowHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CreateFlowRef = AutoDisposeFutureProviderRef<BaseModel>;
String _$toggleFlowHash() => r'36a66579e4c18d0adf8b49b3c20e6171039b861f';

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

/// See also [toggleFlow].
@ProviderFor(toggleFlow)
const toggleFlowProvider = ToggleFlowFamily();

/// See also [toggleFlow].
class ToggleFlowFamily extends Family<AsyncValue<BaseModel>> {
  /// See also [toggleFlow].
  const ToggleFlowFamily();

  /// See also [toggleFlow].
  ToggleFlowProvider call({
    required int flowId,
  }) {
    return ToggleFlowProvider(
      flowId: flowId,
    );
  }

  @override
  ToggleFlowProvider getProviderOverride(
    covariant ToggleFlowProvider provider,
  ) {
    return call(
      flowId: provider.flowId,
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
  String? get name => r'toggleFlowProvider';
}

/// See also [toggleFlow].
class ToggleFlowProvider extends AutoDisposeFutureProvider<BaseModel> {
  /// See also [toggleFlow].
  ToggleFlowProvider({
    required int flowId,
  }) : this._internal(
          (ref) => toggleFlow(
            ref as ToggleFlowRef,
            flowId: flowId,
          ),
          from: toggleFlowProvider,
          name: r'toggleFlowProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$toggleFlowHash,
          dependencies: ToggleFlowFamily._dependencies,
          allTransitiveDependencies:
              ToggleFlowFamily._allTransitiveDependencies,
          flowId: flowId,
        );

  ToggleFlowProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.flowId,
  }) : super.internal();

  final int flowId;

  @override
  Override overrideWith(
    FutureOr<BaseModel> Function(ToggleFlowRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ToggleFlowProvider._internal(
        (ref) => create(ref as ToggleFlowRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        flowId: flowId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BaseModel> createElement() {
    return _ToggleFlowProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ToggleFlowProvider && other.flowId == flowId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, flowId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ToggleFlowRef on AutoDisposeFutureProviderRef<BaseModel> {
  /// The parameter `flowId` of this provider.
  int get flowId;
}

class _ToggleFlowProviderElement
    extends AutoDisposeFutureProviderElement<BaseModel> with ToggleFlowRef {
  _ToggleFlowProviderElement(super.provider);

  @override
  int get flowId => (origin as ToggleFlowProvider).flowId;
}

String _$deleteFlowHash() => r'930da2abf6dc936b473b84287dbc6fcdd5381676';

/// See also [deleteFlow].
@ProviderFor(deleteFlow)
const deleteFlowProvider = DeleteFlowFamily();

/// See also [deleteFlow].
class DeleteFlowFamily extends Family<AsyncValue<BaseModel>> {
  /// See also [deleteFlow].
  const DeleteFlowFamily();

  /// See also [deleteFlow].
  DeleteFlowProvider call({
    required int flowId,
  }) {
    return DeleteFlowProvider(
      flowId: flowId,
    );
  }

  @override
  DeleteFlowProvider getProviderOverride(
    covariant DeleteFlowProvider provider,
  ) {
    return call(
      flowId: provider.flowId,
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
  String? get name => r'deleteFlowProvider';
}

/// See also [deleteFlow].
class DeleteFlowProvider extends AutoDisposeFutureProvider<BaseModel> {
  /// See also [deleteFlow].
  DeleteFlowProvider({
    required int flowId,
  }) : this._internal(
          (ref) => deleteFlow(
            ref as DeleteFlowRef,
            flowId: flowId,
          ),
          from: deleteFlowProvider,
          name: r'deleteFlowProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteFlowHash,
          dependencies: DeleteFlowFamily._dependencies,
          allTransitiveDependencies:
              DeleteFlowFamily._allTransitiveDependencies,
          flowId: flowId,
        );

  DeleteFlowProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.flowId,
  }) : super.internal();

  final int flowId;

  @override
  Override overrideWith(
    FutureOr<BaseModel> Function(DeleteFlowRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteFlowProvider._internal(
        (ref) => create(ref as DeleteFlowRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        flowId: flowId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BaseModel> createElement() {
    return _DeleteFlowProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteFlowProvider && other.flowId == flowId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, flowId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DeleteFlowRef on AutoDisposeFutureProviderRef<BaseModel> {
  /// The parameter `flowId` of this provider.
  int get flowId;
}

class _DeleteFlowProviderElement
    extends AutoDisposeFutureProviderElement<BaseModel> with DeleteFlowRef {
  _DeleteFlowProviderElement(super.provider);

  @override
  int get flowId => (origin as DeleteFlowProvider).flowId;
}

String _$flowDetailHash() => r'7d29d7b286a866fcd8269264a533a2c1e9b0fb89';

abstract class _$FlowDetail extends BuildlessAutoDisposeNotifier<BaseModel> {
  late final int id;

  BaseModel build({
    required int id,
  });
}

/// See also [FlowDetail].
@ProviderFor(FlowDetail)
const flowDetailProvider = FlowDetailFamily();

/// See also [FlowDetail].
class FlowDetailFamily extends Family<BaseModel> {
  /// See also [FlowDetail].
  const FlowDetailFamily();

  /// See also [FlowDetail].
  FlowDetailProvider call({
    required int id,
  }) {
    return FlowDetailProvider(
      id: id,
    );
  }

  @override
  FlowDetailProvider getProviderOverride(
    covariant FlowDetailProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'flowDetailProvider';
}

/// See also [FlowDetail].
class FlowDetailProvider
    extends AutoDisposeNotifierProviderImpl<FlowDetail, BaseModel> {
  /// See also [FlowDetail].
  FlowDetailProvider({
    required int id,
  }) : this._internal(
          () => FlowDetail()..id = id,
          from: flowDetailProvider,
          name: r'flowDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$flowDetailHash,
          dependencies: FlowDetailFamily._dependencies,
          allTransitiveDependencies:
              FlowDetailFamily._allTransitiveDependencies,
          id: id,
        );

  FlowDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  BaseModel runNotifierBuild(
    covariant FlowDetail notifier,
  ) {
    return notifier.build(
      id: id,
    );
  }

  @override
  Override overrideWith(FlowDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: FlowDetailProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<FlowDetail, BaseModel> createElement() {
    return _FlowDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FlowDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FlowDetailRef on AutoDisposeNotifierProviderRef<BaseModel> {
  /// The parameter `id` of this provider.
  int get id;
}

class _FlowDetailProviderElement
    extends AutoDisposeNotifierProviderElement<FlowDetail, BaseModel>
    with FlowDetailRef {
  _FlowDetailProviderElement(super.provider);

  @override
  int get id => (origin as FlowDetailProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
