module ProfileParams
  private

  def profile_params
    params.permit(:first_name, :last_name, :date_of_birth, :about)
  end
end
