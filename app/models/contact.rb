class Contact < ActiveRecord::Base
  validates_presence_of :lat
  validates_presence_of :long
  validates_presence_of :locale
  validates_inclusion_of :locale, :in => %w(ru en de)
end

