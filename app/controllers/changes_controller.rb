class ChangesController < ApplicationController
  def create
    ActiveRecord::Base.transaction do
      project = Project.find(params[:change][:project_id])
      project.update!(status: params[:change][:current])

      changes = project.previous_changes[:status]

      change         = Change.new
      change.user    = current_user
      change.project = project
      change.from    = changes.first
      change.to      = changes.last

      change.save!
    end
  end
end
