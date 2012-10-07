module ApplicationHelper

  def display_video_presenter_links video
    presenters = []
    video.presenters.each do |presenter|
      name_link = link_to_unless_current presenter.display_name, presenter_path(presenter)
      unless presenter.twitter_handle.blank?
        twitter_link = link_to "(@#{presenter.twitter_name})", twitter_path(presenter.twitter_name), :target => "_blank"
      end

      presenter_link = [name_link,twitter_link].join(" ")
      
      presenters << presenter_link
    end

    presenters.join(", ")
      
  end

  def twitter_path twitter_name
    "http://twitter.com/#{twitter_name}"
  end

  ##
  # this method takes a label and a value and displays it with the
  # appropriate divs, etc.. for inclusion on a form
  def attribute_display label, value
#    content_tag(:div,
                content_tag(:label, label,
                            :class => "control-label") +
                content_tag(:div, value,
                            :class => "controls display") +
                content_tag(:div,"", :class => "clear")
#                :class => "control-group")
  end

  ##
  # displays a Yes or No the boolean value passed in
  def yes_no value
    value ? "Yes" : "No"
  end
end
