require "rails_helper"

RSpec.describe "FinancialPlanners", type: :request do
    describe "GET /users" do
        context "ログイン済みでアクセス" do
            before do
                @fp = create(:financial_planner)
            end
            
            it "ログイン処理が正しく行えるか" do
                sign_in @fp
                get financial_planners_path
                expect(response).to have_http_status(200)
            end
        end

        context "未ログインアクセス" do
            it "sign_inにリダイレクト" do
                get financial_planners_path
                expect(response).to redirect_to "/financial_planners/sign_in"
            end
        end
    end
end
