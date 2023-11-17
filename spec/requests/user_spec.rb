require "rails_helper"

RSpec.describe "Users", type: :request do
    describe "GET /users" do
        context "ログイン済みでアクセス" do
            before do
                @user = create(:user)
            end
            
            it "ログイン処理が正しく行えるか" do
                sign_in @user
                get users_path
                expect(response).to have_http_status(200)
            end
        end

        context "未ログインアクセス" do
            it "sign_inにリダイレクト" do
                get users_path
                expect(response).to redirect_to "/users/sign_in"
            end
        end
    end
end
