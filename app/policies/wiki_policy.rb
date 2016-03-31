class WikiPolicy <ApplicationPolicy
  def edit?
    if record.user == user
      true
    else
      false
    end
  end

end
