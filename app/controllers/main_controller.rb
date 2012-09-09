##
# main controller for all misc pages and home page
class MainController < ApplicationController
  # this is the home page that is render for root_path
  def index
    recents
    
    @limit = params[:limit] || 5

    @limit = (@limit.to_i > 50 ? 50 : @limit.to_i)

    if params[:id].nil?
      @video = Video.random
    else
      @video = Video.find(params[:id])
    end

    @all_time = Video.find(:all,
                           :include => [:event],
                           :conditions => ['events.private = ? and available = ?',
                                           false, true],
                           :order => "views desc",
                           :limit => @limit)

    @last_7 = Video.find(:all,
                         :include => [:event],
                         :conditions => ['events.private = ? and available = ?',
                                         false, true],
                         :order => "views_last_7 desc",
                         :limit => @limit)
    
    @last_30 = Video.find(:all,
                          :include => [:event],
                          :conditions => ['events.private = ? and available = ?',
                                          false, true],
                          :order => "views_last_30 desc",
                          :limit => @limit) 
  end

  ##
  # this is a redirect from an old URL
  #
  # probably not needed on confreaks.tv
  def contact
    redirect_to '/contact-us', :status => 301
  end
end
