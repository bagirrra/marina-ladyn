class About < ActiveRecord::Base
  validates_presence_of :locale
  validates_inclusion_of :locale, :in => %w(ru en de)
end
