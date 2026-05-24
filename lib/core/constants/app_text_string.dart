import 'package:easy_localization/easy_localization.dart';

class AppTextString {
  AppTextString._();

  // ─────────────────────────── Technical Keys ───────────────────────────── //
  static const String enLangKey = 'en';
  static const String arLangKey = 'ar';

  // ─────────────────────────── Static Assets ────────────────────────────── //
  static const String defaultAvatarUrl =
      'https://flower.elevateegy.com/uploads/default-profile.png';
  static const String englishProfileState = 'English';
  static const String arabicProfileState = 'Arabic';

  // ─────────────────────────── Symbols / Units ──────────────────────────── //
  static const String id = 'id';
  static const String percentageSign = '%';
  static const String multiply = 'x';
  static const String egp = 'EGP';

  // ─────────────────────────── Language Flags ───────────────────────────── //
  static const String selected = 'selected';
  static const String unSelected = 'unSelected';

  // ─────────────────────────────── Common ───────────────────────────────── //
  static String get loading => 'common.loading'.tr();
  static String get retry => 'common.retry'.tr();
  static String get cancel => 'common.cancel'.tr();
  static String get confirm => 'common.confirm'.tr();
  static String get update => 'common.update'.tr();
  static String get delete => 'common.delete'.tr();
  static String get continueText => 'common.continueBtn'.tr();
  static String get uploadPhoto => 'common.uploadPhoto'.tr();
  static String get gallery => 'common.gallery'.tr();
  static String get chooseFromYourPhotos => 'common.chooseFromYourPhotos'.tr();
  static String get camera => 'common.camera'.tr();
  static String get takeNewPhoto => 'common.takeNewPhoto'.tr();
  static String get fileIsTooLarge => 'common.fileIsTooLarge'.tr();

  // ─────────────────────────────── Errors ───────────────────────────────── //
  static String get navigationError => 'errors.navigation'.tr();

  // ───────────────────────── Auth — Onboarding ──────────────────────────── //
  static String get onboarding => 'auth.onboarding'.tr();
  static String get login => 'auth.login'.tr();
  static String get applyNow => 'auth.applyNow'.tr();
  static String get dontHaveAnAccount => 'auth.dontHaveAnAccount'.tr();
  static String get rememberMe => 'auth.rememberMe'.tr();
  static String get didForgetPassword => 'auth.didForgetPassword'.tr();

  // ───────────────────────── Auth — Apply Form ──────────────────────────── //
  static String get apply => 'auth.apply.apply'.tr();
  static String get welcome => 'auth.apply.header'.tr();
  static String get welcomeTitle => 'auth.apply.title'.tr();
  static String get country => 'auth.apply.country'.tr();
  static String get selectCountry => 'auth.apply.selectCountry'.tr();
  static String get firstLegalName => 'auth.apply.firstLegalName'.tr();
  static String get secondLegalName => 'auth.apply.secondLegalName'.tr();
  static String get vehicleType => 'auth.apply.vehicleType'.tr();
  static String get vehicleNumber => 'auth.apply.vehicleNumber'.tr();
  static String get vehicleLicense => 'auth.apply.vehicleLicense'.tr();
  static String get uploadLicensePhoto => 'auth.apply.uploadLicensePhoto'.tr();
  static String get nationalIdLabel => 'auth.apply.nationalId'.tr();
  static String get uploadNationalIdPhoto =>
      'auth.apply.uploadNationalIdPhoto'.tr();

  // ───────────────────────── Auth — Apply Success ───────────────────────── //
  static String get successApplyHeader => 'auth.successApply.header'.tr();
  static String get successApplyTitle => 'auth.successApply.title'.tr();

  // ───────────────────────── Auth — Labels ──────────────────────────────── //
  static String get emailLabel => 'auth.labels.email'.tr();
  static String get passwordLabel => 'auth.labels.password'.tr();
  static String get currentPasswordLabel => 'auth.labels.currentPassword'.tr();
  static String get newPasswordLabel => 'auth.labels.newPassword'.tr();
  static String get confirmPasswordLabel => 'auth.labels.confirmPassword'.tr();
  static String get confirmPassword => 'auth.labels.confirmPassword'.tr();
  static String get countryLabel => 'auth.labels.country'.tr();
  static String get firstLegalNameLabel => 'auth.labels.firstLegalName'.tr();
  static String get secondLegalNameLabel => 'auth.labels.secondLegalName'.tr();
  static String get vehicleTypeLabel => 'auth.labels.vehicleType'.tr();
  static String get vehicleNumberLabel => 'auth.labels.vehicleNumber'.tr();
  static String get vehicleLicenseLabel => 'auth.labels.vehicleLicense'.tr();
  static String get phoneNumberLabel => 'auth.labels.phoneNumber'.tr();
  static String get idNumberLabel => 'auth.labels.idNumber'.tr();
  static String get idImageLabel => 'auth.labels.idImage'.tr();

  // ───────────────────────── Auth — Hints ───────────────────────────────── //
  static String get enterEmail => 'auth.hints.enterEmail'.tr();
  static String get enterPassword => 'auth.hints.enterPassword'.tr();
  static String get enterYourNewPassword =>
      'auth.hints.enterYourNewPassword'.tr();
  static String get enterCurrentPassword =>
      'auth.hints.enterCurrentPassword'.tr();
  static String get enterConfirmPassword =>
      'auth.hints.enterConfirmPassword'.tr();
  static String get enterFirstName => 'auth.hints.enterFirstName'.tr();
  static String get enterLastName => 'auth.hints.enterLastName'.tr();
  static String get enterPhoneNumber => 'auth.hints.enterPhoneNumber'.tr();
  static String get enterFirstLegalName =>
      'auth.hints.enterFirstLegalName'.tr();
  static String get enterSecondLegalName =>
      'auth.hints.enterSecondLegalName'.tr();
  static String get enterVehicleNumber => 'auth.hints.enterVehicleNumber'.tr();
  static String get uploadVehicleLicensePhoto =>
      'auth.hints.uploadVehicleLicensePhoto'.tr();
  static String get enterNationalIdNumber =>
      'auth.hints.enterNationalIdNumber'.tr();
  static String get uploadIdImagePhoto => 'auth.hints.uploadIdImagePhoto'.tr();

  // ───────────────────── Auth — Forget / Reset Password ─────────────────── //
  static String get forgetPasswordHeader => 'auth.forgetPassword.header'.tr();
  static String get forgetPasswordTitle => 'auth.forgetPassword.title'.tr();
  static String get forgetPasswordHeadLine => 'auth.forgetPassword.header'.tr();
  static String get pleaseEnterYourEmail =>
      'auth.forgetPassword.pleaseEnterYourEmail'.tr();
  static String get emailVerificationHeader =>
      'auth.forgetPassword.emailVerificationHeader'.tr();
  static String get emailVerificationTitle =>
      'auth.forgetPassword.emailVerificationTitle'.tr();
  static String get didResentCode => 'auth.forgetPassword.didResentCode'.tr();
  static String get resend => 'auth.forgetPassword.resend'.tr();
  static String get enterValidCode => 'auth.forgetPassword.enterValidCode'.tr();
  static String get completeFields => 'auth.forgetPassword.completeFields'.tr();
  static String get passwordsDontMatch =>
      'auth.forgetPassword.passwordsDontMatch'.tr();
  static String get messageSentSuccessfully =>
      'auth.forgetPassword.messageSentSuccessfully'.tr();
  static String get otpResentSuccess =>
      'auth.forgetPassword.otpResentSuccess'.tr();
  // ───────────────────── Auth — Forget / Reset Password ─────────────────── //
  static String get resetPasswordHeader =>
      'auth.forgetPassword.resetPasswordHeader'.tr();
  static String get resetPasswordTitle =>
      'auth.forgetPassword.resetPasswordTitle'.tr();
  static String get newPasswordHint =>
      'auth.forgetPassword.newPasswordHint'.tr();
  static String get currentPassword =>
      'auth.forgetPassword.currentPassword'.tr();
  static String get newPassword => 'auth.forgetPassword.newPassword'.tr();

  // ───────────────────────── Auth — Messages ────────────────────────────── //
  // ───────────────────────── Auth — Messages ────────────────────────────── //
  static String get failedToRegister => 'auth.messages.failedToRegister'.tr();
  static String get creatingAccountAgreement =>
      'auth.messages.creatingAccountAgreement'.tr();
  static String get termsAndConditions =>
      'auth.messages.termsAndConditions'.tr();
  static String get alreadyHaveAccount =>
      'auth.messages.alreadyHaveAccount'.tr();
  static String get invalidPhoneNumber =>
      'auth.messages.invalidPhoneNumber'.tr();
  static String get accountCreatedSuccessfully =>
      'auth.messages.accountCreatedSuccessfully'.tr();
  static String get loginSuccess => 'auth.messages.loginSuccess'.tr();
  static String get passwordUpdatedSuccessfully =>
      'auth.messages.passwordUpdatedSuccessfully'.tr();
  static String get failedToUpdatePassword =>
      'auth.messages.failedToUpdatePassword'.tr();
  static String get newPasswordSameAsOld =>
      'auth.messages.newPasswordSameAsOld'.tr();
  static String get pleaseConfirmYourNewPassword =>
      'auth.messages.pleaseConfirmYourNewPassword'.tr();
  static String get pleaseEnterYourCurrentPassword =>
      'auth.messages.pleaseEnterYourCurrentPassword'.tr();
  static String get pleaseEnterYourNewPassword =>
      'auth.messages.pleaseEnterYourNewPassword'.tr();
  static String get emailFocusError => 'auth.messages.emailFocusError'.tr();
  static String get passwordsDoNotMatch =>
      'auth.messages.passwordsDoNotMatch'.tr();
  static String get invalidCode => 'auth.messages.invalidCode'.tr();

  // ─────────────────────────────── Home ─────────────────────────────────── //
  static String get home => 'home.title'.tr();
  static String get driverDetailsNotFound => 'home.driverDetailsNotFound'.tr();
  static String get defaultDeliveryAddress =>
      'home.defaultDeliveryAddress'.tr();
  static String get ordersInHomeTabLog => 'home.ordersInHomeTabLog'.tr();
  static String get homeNav => 'bottomNavBar.home'.tr();

  // ─────────────────────────────── Orders ───────────────────────────────── //
  static String get orders => 'bottomNavBar.orders'.tr();
  static String get myOrders => 'orders.myOrders'.tr();
  static String get myOrdersTitle => 'orders.myOrders'.tr();
  static String get recentOrders => 'orders.recentOrders'.tr();
  static String get noOrdersFound => 'orders.noOrdersFound'.tr();
  static String get flowerOrder => 'orders.flowerOrder'.tr();
  static String get orderDetails => 'orders.orderDetails'.tr();
  static String get pickupAddress => 'orders.pickupAddress'.tr();
  static String get deliveryAddress => 'orders.deliveryAddress'.tr();
  static String get userAddress => 'orders.userAddress'.tr();
  static String get total => 'orders.total'.tr();
  static String get noMoreOrders => 'orders.noMoreOrders'.tr();
  static String get paymentMethod => 'orders.paymentMethod'.tr();
  static String get completedTitle => 'orders.completed'.tr();
  static String get cancelledTitle => 'orders.cancelled'.tr();
  static String get inProgressTitle => 'orders.inProgress'.tr();
  static String get reject => 'orders.reject'.tr();
  static String get accept => 'orders.accept'.tr();
  // Raw status keys used for comparisons (not translated)
  static const String completed = 'completed';
  static const String cancelled = 'canceled';

  // ─────────────────────────────── Profile ──────────────────────────────── //
  static String get profile => 'profile.title'.tr();
  static String get profileNav => 'bottomNavBar.profile'.tr();
  static String get vehicleInfo => 'profile.vehicleInfo'.tr();
  static String get notification => 'profile.notification'.tr();
  static String get chooseLanguage => 'profile.chooseLanguage'.tr();
  static String get language => 'profile.language'.tr();
  static String get english => 'profile.english'.tr();
  static String get arabic => 'profile.arabic'.tr();
  static String get switchToArabic => 'profile.switchToArabic'.tr();
  static String get switchToEnglish => 'profile.switchToEnglish'.tr();
  static String get termsAndConditionsPolicy =>
      'profile.termsAndConditionsPolicy'.tr();
  static String get aboutUsPolicy => 'profile.aboutUsPolicy'.tr();
  static String get savedAddresses => 'profile.savedAddresses'.tr();
  static String get termsAppBarTitleEn => 'profile.termsAppBarTitle'.tr();
  static String get termsAppBarTitleAr => 'profile.termsAppBarTitle'.tr();
  static String get appInfoAppBarTitleEn => 'profile.appInfoAppBarTitle'.tr();
  static String get appInfoAppBarTitleAr => 'profile.appInfoAppBarTitle'.tr();
  static String get noTermsDataAvailable => 'profile.noTermsDataAvailable'.tr();

  // ─────────────────────────── Edit Profile ─────────────────────────────── //
  static String get editProfile => 'editProfile.title'.tr();
  static String get change => 'editProfile.change'.tr();
  static String get uploadImage => 'editProfile.uploadImage'.tr();
  static String get updateProfile => 'editProfile.updateProfile'.tr();
  static String get firstName => 'editProfile.firstName'.tr();
  static String get lastName => 'editProfile.lastName'.tr();
  static String get phoneNumber => 'editProfile.phoneNumber'.tr();
  static String get gender => 'editProfile.gender'.tr();
  static String get female => 'editProfile.female'.tr();
  static String get male => 'editProfile.male'.tr();
  static String get profilePhotoUpdatedSuccessfully =>
      'editProfile.profilePhotoUpdatedSuccessfully'.tr();
  static String get profileUpdatedSuccessfully =>
      'editProfile.profileUpdatedSuccessfully'.tr();
  static String get noChangesToUpdate => 'editProfile.noChangesToUpdate'.tr();

  // ─────────────────────────────── Logout ───────────────────────────────── //
  static String get logout => 'logout'.tr();
  static String get logoutText => 'logout'.tr();
  static String get confirmLogout => 'common.confirmLogout'.tr();

  // ─────────────────────────────── Success ──────────────────────────────── //
  // ─────────────────────────────── Success ──────────────────────────────── //
  static String get done => 'success.done'.tr();
  static String get thankYou => 'success.thankYou'.tr();
  static String get theOrderDeliveredSuccessfully =>
      'success.theOrderDeliveredSuccessfully'.tr();
}
