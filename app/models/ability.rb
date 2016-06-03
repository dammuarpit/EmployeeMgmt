class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new
=begin
    if user.role_id.blank?
      can :read, Department
    else
      user.role_id.each do |role|
        role_obj = Role.find_by(id: role)
        role_obj.permissions.each do |per|
          if per.block.blank? && per.subject_class == 'all'
            can per.action.to_sym, per.subject_class.to_sym
          elsif per.block.blank?
            can per.action.to_sym, per.subject_class.constantize
          elsif per.subject_class == 'all'
            can per.action.to_sym, per.subject_class.to_sym, per.block
          else
            can per.action.to_sym, per.subject_class.constantize, per.block
          end
        end
      end
    end
=end

can :manage, :all
    # $permissions.each do |per|
    #   if per.block.blank? && per.subject_class == 'all'
    #     can per.action.to_sym, per.subject_class.to_sym
    #   elsif per.block.blank?
    #     can per.action.to_sym, per.subject_class.constantize
    #   elsif per.subject_class == 'all'
    #     can per.action.to_sym, per.subject_class.to_sym, per.block
    #   else
    #     can per.action.to_sym, per.subject_class.constantize, per.block
    #   end
    # end

  end

end
