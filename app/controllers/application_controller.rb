class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        case resource
        when User
            "/users"
        when FinancialPlanner
            "/financial_planners"
        end
    end

    def after_sign_out_path_for(resource)
        "/"
    end
end
