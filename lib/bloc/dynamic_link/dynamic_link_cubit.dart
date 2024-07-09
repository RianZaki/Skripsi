import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dynamic_link_state.dart';

class DynamicLinkCubit extends Cubit<DynamicLinkState> {
  String idArtikel= "";

  DynamicLinkCubit() : super(DynamicLinkInitial());

  void saveIdArticle(String id) {
    idArtikel = id;
  }

  void clearIdArticle(){
    idArtikel = "";
  }
}
