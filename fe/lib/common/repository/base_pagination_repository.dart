import '../model/default_model.dart';
import '../param/default_param.dart';
import '../param/pagination_param.dart';

abstract class IBasePaginationRepository<T extends Base,
S extends DefaultParam> {
  Future<ResponseModel<PaginationModel<T>>> paginate({
    required PaginationParam paginationParams,
    S? param,
    int? path,
  });
}