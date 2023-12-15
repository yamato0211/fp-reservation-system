class Users::UnlocksController < Devise::UnlocksController
  def show
    super
  end
  def new
    super
  end

  def create
    super
  end


  protected

  def after_sending_unlock_instructions_path_for(resource)
    super(resource)
  end

  def after_unlock_path_for(resource)
    super(resource)
  end
end
