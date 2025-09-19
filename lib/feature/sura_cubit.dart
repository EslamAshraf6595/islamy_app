import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamy_app/data/sura_data/get_loacal_sura_data.dart';
import 'package:islamy_app/domain/sura_states.dart';

class SuraCubit extends Cubit<SuraState> {
  SuraCubit() : super(SuraInitial());

  Future<void> loadSura(int index) async {
    emit(SuraLoading());
    try {
      final content = await ReadLocalSuraData.readSuraData(
        filePath: "assets/Suras/${index + 1}.txt",
      );
      emit(SuraLoaded(content));
    } catch (e) {
      emit(SuraError(e.toString()));
    }
  }
}
