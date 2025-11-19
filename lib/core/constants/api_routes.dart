class ApiRoutes {
  // --- Auth ---
  static const login = 'auth/login';
  static const register = 'auth/register';
  static const forgotPassword = 'otp/forgot-password';
  static const resetPassword = 'otp/reset-password';
  static const verifyOtp = 'otp/verify-otp';

  // --- Saving Fund ---
  static const savingFund = 'saving-fund';
  static const getSavingFunds = 'saving-fund/user';
  static const selectSavingFund = 'saving-fund/select';

  // --- User proflie ---
  static const userProfile = 'user-profile/me';  
}
