#///////////////////////////////////////////////////////////////////////////////
# Page options, layouts, aliases and proxies
#///////////////////////////////////////////////////////////////////////////////

page "/index.html", :layout => false

#///////////////////////////////////////////////////////////////////////////////
# Premailer
#///////////////////////////////////////////////////////////////////////////////

class PreMailer < Middleman::Extension
	def registered(app)
		require "premailer"
		require 'nokogiri'

		app.after_build do |builder|
			prefix = "#{build_dir}#{File::SEPARATOR}"
			Dir.chdir(build_dir) do
				Dir.glob('**/*.html') do |file|
					premailer = Premailer.new(file,
						warn_level: Premailer::Warnings::SAFE,
						adapter: :nokogiri,
						preserve_styles: false,
						remove_comments: true,
						remove_ids: true,
						remove_classes: true
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

#::Middleman::Extensions.register(:inline_premailer, PreMailer)

#activate :inline_premailer

activate :livereload

#///////////////////////////////////////////////////////////////////////////////
# Paths
#///////////////////////////////////////////////////////////////////////////////

set :css_dir, 'stylesheets'
set :images_dir, 'images'

#///////////////////////////////////////////////////////////////////////////////
# Build-specific configuration
#///////////////////////////////////////////////////////////////////////////////

configure :build do
   set :relative_links, true
   activate :relative_assets
end