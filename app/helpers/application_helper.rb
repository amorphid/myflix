module ApplicationHelper
  def increment_tabindex_by_one
    @tabindex_count ||= 0
    @tabindex_count  += 1
  end
end
