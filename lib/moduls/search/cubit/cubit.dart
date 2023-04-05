import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/moduls/search/cubit/states.dart';
import '../../../layout/shop_app/search_model.dart';
import '../../../network/end_point.dart';
import '../../../network/remote/dio_helper.dart';
import '../../../shared/constants.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search( String text)
  {
    emit(SearchLoadingState());
    DioHelper.postData(

        url: SEARCH,
        token: token,
        data: {
          'text' : text,
        },
    ).then((value)
    {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());

    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}