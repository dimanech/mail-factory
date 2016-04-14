module PreMailer
  class << self
    def registered(app)
      require "premailer"
      app.after_build do |builder|
        prefix = "#{build_dir}#{File::SEPARATOR}"
        Dir.chdir(build_dir) do
          Dir.glob('**/*.html') do |file|
            premailer = Premailer.new(file,
              :warn_level => Premailer::Warnings::SAFE,
              :preserve_styles => false,
              :css_to_attributes => true,
              :remove_comments => true,
              :remove_ids => true,
              :remove_classes => true
            )
            File.open(file, "w") do |f|
              f.write(premailer.to_inline_css)
            end
            premailer.warnings.each do |w|
              builder.say_status :premailer, "#{w[:message]} (#{w[:level]}) may not render properly in #{w[:clients]}"
            end
            builder.say_status :premailer, "#{prefix}#{file}"
          end
        end
      end
    end
    alias :included :registered
  end
end
::Middleman::Extensions.register(:inline_premailer, PreMailer)