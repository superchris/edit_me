 
namespace :edit_me do
  desc "Install files"
  task :install_files do

    FileList[File.join(File.dirname(__FILE__), '..', 'images', "**/*")].each do |f|
      cp f, File.join(RAILS_ROOT, "public", "images")
    end

  end
end
