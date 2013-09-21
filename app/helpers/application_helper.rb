module ApplicationHelper
  def increment_tabindex_by_one
    @tabindex ||= 0
    @tabindex  += 1
  end
end
