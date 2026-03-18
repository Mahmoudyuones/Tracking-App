import '../../../../config/base_state/base_state.dart';

class EditProfileStates extends BaseState<EditProfileStates> {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String photoUrl;
  final bool isValidForm;
  final bool isLoadingProfile;

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
  ];

  @override
  EditProfileStates copyWith({
    EditProfileStates? data,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? photoUrl,
    bool? isValidForm,
    bool? isLoadingProfile,
    String? errorMessage,
    bool? isEmpty,
  }) {
    return EditProfileStates(
      data: data,
      errorMessage: errorMessage ?? this.errorMessage,
      isEmpty: isEmpty ?? this.isEmpty,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      isValidForm: isValidForm ?? this.isValidForm,
      isLoadingProfile: isLoadingProfile ?? this.isLoadingProfile,
    );
  }
}
