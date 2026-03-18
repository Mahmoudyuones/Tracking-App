import 'dart:io';

sealed class EditProfileIntents {
  const EditProfileIntents();
}

class UpdateProfilePhotoIntent extends EditProfileIntents {
  final File photo;

  const UpdateProfilePhotoIntent(this.photo);
}

class FirstNameChangedIntent extends EditProfileIntents {
  final String firstName;

  const FirstNameChangedIntent(this.firstName);
}

class LastNameChangedIntent extends EditProfileIntents {
  final String lastName;

  const LastNameChangedIntent(this.lastName);
}

class EmailChangedIntent extends EditProfileIntents {
  final String email;

  const EmailChangedIntent(this.email);
}

class PhoneChangedIntent extends EditProfileIntents {
  final String phone;

  const PhoneChangedIntent(this.phone);
}

class UpdateProfileSubmitIntent extends EditProfileIntents {
  const UpdateProfileSubmitIntent();
}
