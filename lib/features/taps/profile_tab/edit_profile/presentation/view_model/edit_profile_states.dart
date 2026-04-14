import '../../../../../../config/base_state/base_state.dart';
import '../../data/models/response/edit_profile_response_model.dart';

class EditProfileStates extends BaseState<EditProfileResponseModel> {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String photoUrl;
  final bool isValidForm;
  final bool isLoadingProfile;
  final bool isDirty;

  const EditProfileStates({
    super.data,
    super.errorMessage,
    super.isEmpty,
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
    this.photoUrl = '',
    this.isValidForm = false,
    this.isLoadingProfile = false,
    this.isDirty = false,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    firstName,
    lastName,
    email,
    phone,
    photoUrl,
    isValidForm,
    isLoadingProfile,
    isDirty,
  ];

  @override
  EditProfileStates copyWith({
    EditProfileResponseModel? data,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? photoUrl,
    bool? isValidForm,
    bool? isLoadingProfile,
    String? errorMessage,
    bool? isEmpty,
    bool? isDirty,
  }) {
    return EditProfileStates(
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      isEmpty: isEmpty ?? this.isEmpty,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      isValidForm: isValidForm ?? this.isValidForm,
      isLoadingProfile: isLoadingProfile ?? this.isLoadingProfile,
      isDirty: isDirty ?? this.isDirty,
    );
  }
}
