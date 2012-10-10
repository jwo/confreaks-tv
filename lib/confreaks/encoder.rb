module Confreaks
  ##
  # this class consists of the logic to submit a job to ZenCoder and
  # Youtube it is a utility class, and instances should not be
  # created.
  class Encoder
    ##
    # this method submits the data associated with the asset that is
    # passed in, to Youtube using the
    def self.submit_to_youtube asset
      @asset = asset
      video = @asset.video

      log_file_name = "#{Time.now.strftime('%y-%m-%d-%I-%M-%S')}-#{video.id}-#{video.slug}.log"

      log = File.open(log_file_name, 'w')

      creds = "--email=coby@confreaks.com --password=c0nFr34k5"
      
      title = %&--title="#{@asset.video.title} by #{@asset.video.display_presenters}"&
      category = %&--category="Tech"&
      #description = ""
      mod_description = @asset.video.abstract.gsub("!","\!").gsub('"','\"').gsub("'","\'")
      description = %&--description="#{mod_description}"&
      keywords = %&--keywords="#{@asset.video.event.short_code}"&

      video_info = [title,description,category,keywords].join(" ")

      file = "/home/deploy/www.confreaks.net/shared" + @asset.data.url.split("?")[0]
      log.puts video_info
      log.puts file
      
      command = "python /home/deploy/youtube-upload/youtube-upload-0.7.1/bin/youtube-upload #{creds} #{video_info} #{file}"

      log.puts "Command: #{command}"

      results = `#{command}`

      log.puts "*#{results}*"
      
      youtube_code = results.split("=")[1]

      log.puts "You Tube Code: #{youtube_code}"

      if youtube_code
        
        @asset.video.youtube_code = youtube_code
        @asset.video.save
      end
      
      log.close

      if youtube_code.empty?
        out = false
      else
        out = true
      end

      return out
    end

    def self.submit_to_zencoder asset, size=nil
      @asset = asset

      @asset.data.url

      if size.nil?
        template_file = "#{RAILS_ROOT}/lib/templates/zencoder-job-template.erb"
      elsif size == "audio"
        template_file = "#{RAILS_ROOT}/lib/templates/zencoder-job-template-audio-only.erb"
      elsif size == "small"
        template_file = "#{RAILS_ROOT}/lib/templates/zencoder-job-template-small-only.erb"
      end

      @base_file_name = @asset.video.to_param

      # Generate the Json template to be posted to ZenCoder
      @json_data = Confreaks::Renderer.new(template_file, binding).render

      @response = Zencoder::Job.create(@json_data)

      # Process Zencoder response and generate associated assets
      @asset.zencoder_response = @response.body
      @asset.zencoder_job_id = @response.body['id']

      @response.body['outputs'].each do | output |
        a = Asset.new
        a.generated_by_asset_id = @asset.id
        a.zencoder_job_id = @asset.zencoder_job_id
        a.zencoder_output_id = output['id']
        a.description = output['label']

        if a.description == "audio" then
          a.asset_type = AssetType.find_by_description("Audio")
        else
          a.asset_type = AssetType.find_by_description("Video")
        end

        @asset.video.assets << a
      end

      @asset.save

      return @json_data, @response
    end
  end
end
