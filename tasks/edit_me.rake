module EditMe
  PLUGIN_ROOT = File.join(File.dirname(__FILE__),  '..')
  ASSET_FILES = FileList[PLUGIN_ROOT + '/public/**/*']
end

namespace :edit_me do
  desc "Install files"
  task :install_files do

    FileList[File.join(File.dirname(__FILE__), '..', 'images', "**/*")].each do |f|
      cp f, File.join(RAILS_ROOT, "public", "images")
    end

  end

  desc 'Installs required assets'
  task :install do
    verbose = true
    EditMe::ASSET_FILES.each do |file|
      path = File.dirname(file) + '/'
      path.gsub!(EditMe::PLUGIN_ROOT, RAILS_ROOT)
      destination = File.join(path, File.basename(file))
      puts " * Copying %-50s to %s" % [file, path]
      FileUtils.mkpath(path) unless File.directory?(path)
      FileUtils.cp [file], path unless File.directory?(file)
    end
  end

  desc 'Removes assets for the plugin'
  task :remove do
    ASSET_FILES.each do |file|
      path = File.dirname(file) + '/'
      path.gsub!(EditMe::PLUGIN_ROOT, RAILS_ROOT)
      path.gsub!('assets', 'public')
      path = File.join(path, File.basename(file))
      puts ' * Removing %s' % path.gsub(RAILS_ROOT, '')
      FileUtils.rm [path]
    end
  end
end
