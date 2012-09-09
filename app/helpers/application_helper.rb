module ApplicationHelper

  def display_video_presenter_links video
    presenters = []
    video.presenters.each do |presenter|
      name_link = link_to presenter.display_name, presenter_path(presenter)
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
end
