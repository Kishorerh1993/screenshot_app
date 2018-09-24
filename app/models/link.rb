class Link < ApplicationRecord
  belongs_to :campaign
  validates :url, uniqueness: true
  require 'csv'
  require 'capybara/poltergeist'


  def self.import(file)
    CSV.foreach(file.path,headers: true) do |row|
      Link.create! row.to_hash
    end
  end


end


