class Change < ApplicationRecord
  attr_accessor :current

  # Associations
  #
  belongs_to :user
  belongs_to :project, counter_cache: :changes_count, touch: true
  belongs_to :comment, optional: true

  accepts_nested_attributes_for :comment, reject_if: { body: :blank? }, allow_destroy: true

  # Scopes
  #
  default_scope { order(created_at: :desc) }

  # Callbacks
  #
  after_create_commit do
    broadcast_prepend_to :changes, partial: 'changes/change', locals: { change: self }, target: :comments
  end
end
