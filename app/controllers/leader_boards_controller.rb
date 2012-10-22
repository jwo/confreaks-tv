class LeaderBoardsController < ApplicationController
  def index
     @limit = params[:limit] || 5

    @limit =(@limit.to_i > 50 ? 50 : @limit.to_i)
    
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
end
