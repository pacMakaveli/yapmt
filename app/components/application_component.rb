class ApplicationComponent < ViewComponent::Base
  include Turbo::FramesHelper
  delegate :fluent, :turbo_frame_tag, to: :helpers
end