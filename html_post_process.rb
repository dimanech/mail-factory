module HtmlPostProcess
  class << self
    def registered(app)
      app.after_build do |builder|
        Dir.chdir(build_dir) do
          Dir.glob('**/*.html') do |file|
            remove_strings=File.read(file).gsub('-premailer-cellpadding: 0;', '').gsub('-premailer-cellspacing: 0;', '').gsub(': ', ':').gsub('; ' , ';').gsub(', sans' , ',sans')
            File.open(file, "w") do |f|
              f.write(remove_strings)
            end
            builder.say_status "postprecess", "#{file}"
          end
        end
      end
    end
    alias :included :registered
  end
end
::Middleman::Extensions.register(:html_post_process, HtmlPostProcess)