module FloodRiskEngine
  class EnrollmentPolicy < ApplicationPolicy
    def index?
      user.present? && user.has_any_role?
    end

    def create?
      system_user? || super_agent_user? || admin_agent_user?
    end

    def show_continue_button?
      create? && record.present? && !record.complete?
    end

    def show?
      super && user.present? && user.has_any_role?
    end

    def deregister?
      (system_user? || super_agent_user?) && enrollment_submitted?
    end

    def change_assisted_digital?
      (system_user? || super_agent_user?) && enrollment_submitted?
    end

    def edit?
      (system_user? || super_agent_user? || admin_agent_user?) && enrollment_submitted?
    end

    def update?
      deregister?
    end

    # Whether we can edit an erollment's exemptions.
    # This needs to live here rather than in the enrollment_exemptions policy
    # as here we have an enrollment, but there we would have neither an instantiated
    # enrollment_exemptions or enrollment.
    def edit_exemptions?
      !record.submitted?
    end

    class Scope < Scope
      def resolve
        if user.try! :has_any_role?
          scope.all
        else
          scope.none
        end
      end
    end

    private

    def enrollment_submitted?
      record.present? && record.submitted?
    end
  end
end
