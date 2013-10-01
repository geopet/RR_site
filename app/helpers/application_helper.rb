module ApplicationHelper

  #Return a title on a per-page basis...
  def title
    base_title = "RR Project - Coming Soon!!!"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  def logo
    image_tag("RRMockLogo.png", :alt => "Logo Will Go Here", :class => "round")
  end
end
