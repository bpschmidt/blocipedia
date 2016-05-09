class WikiPolicy <ApplicationPolicy
  def edit?
    if record.user == user
      true
    else
      false
    end
  end


  def show?
    if @record.private
      if @user.admin? || @user.premium? || @record.user == @user
        return true
      else
        return false
      end
    else
      return true
    end
  end

  def destroy?
    if @user.admin? || @record.user == @user
      return true
    else
      return false
    end
  end
end
