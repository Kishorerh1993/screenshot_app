class Campaign < ApplicationRecord
  has_many :links
  validates :name, uniqueness: true
  # require 'phantomjs'
  require 'capybara/poltergeist'
  require 'zip'


  def take_screenshot
    begin      
      Capybara.default_driver = :poltergeist
      browser = Capybara.current_session
      count=1
      self.links.order(:id).map{|url| url.url}.each do |row|
        browser.visit (row)
        sleep 2
        browser.save_screenshot("#{Rails.root}/public/images/#{self.name}/#{count}"+".png",:selector => '.QBXjJ')
        count=count+1
      end

      a=self.name
      directory = "#{Rails.root}/public/images/#{self.name}"
      puts directory
      zipfile_name = "#{self.name}"+".zip"

      Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
            Dir.chdir directory
            Dir.glob("**/*").reject {|fn| File.directory?(fn) }.each do |file|
              puts "Adding #{file}"
              zipfile.add(file.sub(directory + '/', ''), file)
            end
      end
      
    rescue
      puts "timeout"
    end

    
  end
end
