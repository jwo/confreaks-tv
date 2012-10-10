module VideosHelper
  def display_presenters_with_links video
    out = ""
    video.presenters.each do | presenter |
      out += link_to_unless_current(presenter.display_name, presenter_path(presenter)) + ", "
    end
    out = out [0,out.length-2]
  end

  def display_presenters_with_external_links video
    out = []
    video.presenters.each do | presenter|
      unless presenter.twitter_handle.blank?
        out << link_to_unless_current(presenter.display_name, "http://twitter.com/#{presenter.twitter_handle}", :target => "_blank")
      else
        out << presenter.display_name
      end
    end
    return out.join(", ")
  end

end
