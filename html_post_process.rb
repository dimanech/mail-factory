module HtmlPostProcess
  class << self
    def registered(app)
      app.after_build do |builder|
        Dir.chdir(build_dir) do
          Dir.glob('**/*.html') do |file|
            postprecess=File.read(file)
            remove_bracket=postprecess.gsub('-premailer-cellpadding: 0;', '').gsub('-premailer-cellspacing: 0;', '').gsub(': ', ':').gsub('; ' , ';').gsub(', sans' , ',sans')
            File.open(file, "w") do |f|
              f.write(remove_bracket)
            end
            builder.say_status :postprecess, "#{file}"
          end
        end
      end
    end
    alias :included :registered
  end
end
::Middleman::Extensions.register(:html_post_process, HtmlPostProcess)