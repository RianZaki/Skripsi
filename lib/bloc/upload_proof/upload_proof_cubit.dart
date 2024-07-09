import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recything_mobile/repositories/upload_proof_repo.dart';

part 'upload_proof_state.dart';

class UploadProofCubit extends Cubit<UploadProofState> {
  UploadProofCubit() : super(UploadProofInitial());

  UploadProofRepo _uploadProofRepo = UploadProofRepo();

  final _imagePicker = ImagePicker();
  List<XFile> _images = [];

  void resetState() {
    _images.clear();
    emit(UploadProofInitial());
  }

  void selectImages() async {
    List<XFile> selectedImages = await _imagePicker.pickMultiImage();

    if (selectedImages.isNotEmpty) {
      emit(UploadProofLoading());
      _images.addAll(selectedImages);
      emit(UploadProofSuccess(images: _images));
    }
  }

  Future<bool> isImageSizeValidated() async {
    double totalSize = 0;

    for (int i = 0; i < _images.length; i++) {
      totalSize += await _images[i].length() / (1024 * 1024);
    }

    print('$totalSize Mb');

    if (totalSize > 20) {
      emit(UploadProofToServerFailed(errorMsg: 'Ukuran foto melebihi 20 Mb'));
      return false;
    }

    return true;
  }

  void deleteImage({required int index}) async {
    emit(UploadProofLoading());
    _images.removeAt(index);
    emit(UploadProofSuccess(images: _images));
  }

  void uploadProof({
    required String missionId,
    required String description,
  }) async {
    try {
      emit(UploadProofToServerLoading());
      await _uploadProofRepo.uploadProof(
          missionId: missionId, description: description, images: _images);
      emit(UploadProofToServerSuccess());
    } catch (e) {
      emit(UploadProofToServerFailed(errorMsg: e.toString()));
    }
  }

  Future<void> updateProof(
      {required String description, required String transactionId}) async {
    try {
      emit(UploadProofToServerLoading());
      final res = await _uploadProofRepo.updateProof(
          description: description,
          images: _images,
          transactionId: transactionId);
      emit(UpdateProofToServerSuccess(successMsg: res));
    } catch (e) {
      emit(UpdateProofToServerFailed(errorMsg: e.toString()));
    }
  }
}
