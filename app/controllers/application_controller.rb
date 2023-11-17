class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        case resource
        when User
            users_path
        when FinancialPlanner
            financial_planners_path
        end
    end

    def after_sign_out_path_for(resource)
        root_path
    end
end
