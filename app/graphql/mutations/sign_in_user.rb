=begin
mutation {
  signinUser(
    email: {
      email: "seba@seba.com"
      password: "123456"
    }
  ){
    token
    user {
      id
    }
  }
}

{
  "data": {
    "signinUser": {
      "token": "i0D2Qch3Coehr59SWccYK8yNpA==--puTYh/LIojK/B6G6--hOMLaBuBn///gZ1ffPTeyA==",
      "user": {
        "id": "1"
      }
    }
  }
}
=end

module Mutations
  class SignInUser < BaseMutation

    argument :email, Types::AuthProviderEmailInput, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(email: nil)
      return unless email

      user = User.find_by email: email[:email]

      return unless user
      return unless user.authenticate(email[:password])

      # use Ruby on Rails - ActiveSupport::MessageEncryptor, to build a token
      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
      token = crypt.encrypt_and_sign("user-id:#{ user.id }")

      context[:session][:token] = token

      { user: user, token: token }
    end
    
  end
end