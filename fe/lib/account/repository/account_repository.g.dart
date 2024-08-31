// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_repository.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element

class _AccountRepository implements AccountRepository {
  _AccountRepository(
    this._dio, {
    this.baseUrl,
    this.errorLogger,
  }) {
    baseUrl ??= 'http://13.124.223.172:8080/api/v1/finances';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<ResponseModel<BankBaseModel<AccountDetailModel>>> getAccount(
      {required String accountNo}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'token': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<ResponseModel<BankBaseModel<AccountDetailModel>>>(
            Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
                .compose(
                  _dio.options,
                  '/current-accounts/${accountNo}',
                  queryParameters: queryParameters,
                  data: _data,
                )
                .copyWith(
                    baseUrl: _combineBaseUrls(
                  _dio.options.baseUrl,
                  baseUrl,
                )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ResponseModel<BankBaseModel<AccountDetailModel>> _value;
    try {
      _value = ResponseModel<BankBaseModel<AccountDetailModel>>.fromJson(
        _result.data!,
        (json) => BankBaseModel<AccountDetailModel>.fromJson(
          json as Map<String, dynamic>,
          (json) => AccountDetailModel.fromJson(json as Map<String, dynamic>),
        ),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ResponseModel<BankBaseModel<AccountModel>>> createAccount(
      {required AccountCreateParam param}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'token': 'true'};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(param.toJson());
    final _options =
        _setStreamType<ResponseModel<BankBaseModel<AccountModel>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/current-accounts',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ResponseModel<BankBaseModel<AccountModel>> _value;
    try {
      _value = ResponseModel<BankBaseModel<AccountModel>>.fromJson(
        _result.data!,
        (json) => BankBaseModel<AccountModel>.fromJson(
          json as Map<String, dynamic>,
          (json) => AccountModel.fromJson(json as Map<String, dynamic>),
        ),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ResponseModel<BankListBaseModel<AccountDetailModel>>>
      getAccounts() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'token': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<ResponseModel<BankListBaseModel<AccountDetailModel>>>(
            Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
                .compose(
                  _dio.options,
                  '/current-accounts',
                  queryParameters: queryParameters,
                  data: _data,
                )
                .copyWith(
                    baseUrl: _combineBaseUrls(
                  _dio.options.baseUrl,
                  baseUrl,
                )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ResponseModel<BankListBaseModel<AccountDetailModel>> _value;
    try {
      _value = ResponseModel<BankListBaseModel<AccountDetailModel>>.fromJson(
        _result.data!,
        (json) => BankListBaseModel<AccountDetailModel>.fromJson(
          json as Map<String, dynamic>,
          (json) => AccountDetailModel.fromJson(json as Map<String, dynamic>),
        ),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ResponseModel<BankBaseModel<AccountHolderModel>>> getHolder(
      {required String accountNo}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'token': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<ResponseModel<BankBaseModel<AccountHolderModel>>>(
            Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
                .compose(
                  _dio.options,
                  '/current-accounts/${accountNo}/account-holder',
                  queryParameters: queryParameters,
                  data: _data,
                )
                .copyWith(
                    baseUrl: _combineBaseUrls(
                  _dio.options.baseUrl,
                  baseUrl,
                )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ResponseModel<BankBaseModel<AccountHolderModel>> _value;
    try {
      _value = ResponseModel<BankBaseModel<AccountHolderModel>>.fromJson(
        _result.data!,
        (json) => BankBaseModel<AccountHolderModel>.fromJson(
          json as Map<String, dynamic>,
          (json) => AccountHolderModel.fromJson(json as Map<String, dynamic>),
        ),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ResponseModel<BankBaseModel<AccountBalanceModel>>> getBalance(
      {required String accountNo}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'token': 'true'};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<ResponseModel<BankBaseModel<AccountBalanceModel>>>(
            Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
                .compose(
                  _dio.options,
                  '/current-accounts/${accountNo}/balance',
                  queryParameters: queryParameters,
                  data: _data,
                )
                .copyWith(
                    baseUrl: _combineBaseUrls(
                  _dio.options.baseUrl,
                  baseUrl,
                )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ResponseModel<BankBaseModel<AccountBalanceModel>> _value;
    try {
      _value = ResponseModel<BankBaseModel<AccountBalanceModel>>.fromJson(
        _result.data!,
        (json) => BankBaseModel<AccountBalanceModel>.fromJson(
          json as Map<String, dynamic>,
          (json) => AccountBalanceModel.fromJson(json as Map<String, dynamic>),
        ),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<
          ResponseModel<
              BankBaseModel<RecListModel<AccountTransactionHistoryModel>>>>
      getTransactionHistory(
          {required AccountTransactionHistoryParam param}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'token': 'true'};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(param.toJson());
    final _options = _setStreamType<
            ResponseModel<
                BankBaseModel<RecListModel<AccountTransactionHistoryModel>>>>(
        Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/current-accounts/transaction-history',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ResponseModel<
        BankBaseModel<RecListModel<AccountTransactionHistoryModel>>> _value;
    try {
      _value = ResponseModel<
          BankBaseModel<RecListModel<AccountTransactionHistoryModel>>>.fromJson(
        _result.data!,
        (json) => BankBaseModel<
            RecListModel<AccountTransactionHistoryModel>>.fromJson(
          json as Map<String, dynamic>,
          (json) => RecListModel<AccountTransactionHistoryModel>.fromJson(
            json as Map<String, dynamic>,
            (json) => AccountTransactionHistoryModel.fromJson(
                json as Map<String, dynamic>),
          ),
        ),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<ResponseModel<BankListBaseModel<AccountTransferModel>>>
      transferDeposit({required AccountTransferParam param}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'token': 'true'};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(param.toJson());
    final _options =
        _setStreamType<ResponseModel<BankListBaseModel<AccountTransferModel>>>(
            Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
                .compose(
                  _dio.options,
                  '/current-accounts/transfer',
                  queryParameters: queryParameters,
                  data: _data,
                )
                .copyWith(
                    baseUrl: _combineBaseUrls(
                  _dio.options.baseUrl,
                  baseUrl,
                )));
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ResponseModel<BankListBaseModel<AccountTransferModel>> _value;
    try {
      _value = ResponseModel<BankListBaseModel<AccountTransferModel>>.fromJson(
        _result.data!,
        (json) => BankListBaseModel<AccountTransferModel>.fromJson(
          json as Map<String, dynamic>,
          (json) => AccountTransferModel.fromJson(json as Map<String, dynamic>),
        ),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
