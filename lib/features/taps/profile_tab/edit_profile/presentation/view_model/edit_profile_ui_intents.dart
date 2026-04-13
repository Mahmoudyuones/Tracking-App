sealed class EditProfileUiIntents {
  const EditProfileUiIntents();
}

class ShowLoadingIntent extends EditProfileUiIntents {}

class ShowErrorIntent extends EditProfileUiIntents {
  final String message;

  const ShowErrorIntent(this.message);
}

class ShowPhotoLoadingIntent extends EditProfileUiIntents {}

class UpdateProfileSuccessIntent extends EditProfileUiIntents {
  final String message;

  const UpdateProfileSuccessIntent(this.message);
}

class UpdatePhotoSuccessIntent extends EditProfileUiIntents {
  const UpdatePhotoSuccessIntent();
}
