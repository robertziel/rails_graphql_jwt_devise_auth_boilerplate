module Types
  class MutationType < Types::BaseObject

    # Authentication
    field :auth_login, mutation: Mutations::Auth::Login
    field :auth_sign_up, mutation: Mutations::Auth::SignUp
    field :auth_reset_password, mutation: Mutations::Auth::ResetPassword
    field :auth_send_reset_password_instructions,
          mutation: Mutations::Auth::SendResetPasswordInstructions
    field :auth_unlock, mutation: Mutations::Auth::Unlock
    field :auth_resend_unlock_instructions, mutation: Mutations::Auth::ResendUnlockInstructions

    # Profile
    field :profile_update, mutation: Mutations::Profile::Update
  end
end
