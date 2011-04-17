class FrontPage < ActiveRecord::Base
  attr_accessor :header
  attr_accessor :footer
  
  after_find :set_properties
  before_save :update_db_properties
  
  def set_properties
    self.header = case I18n.locale
      when :ru then header_ru
      when :en then header_en
      when :de then header_de
    end
    self.footer = case I18n.locale
      when :ru then footer_ru
      when :en then footer_en
      when :de then footer_de
    end
  end
  
  def update_db_properties
    self.header_ru = header if I18n.locale == :ru
    self.header_en = header if I18n.locale == :en
    self.header_de = header if I18n.locale == :de
    
    self.footer_ru = footer if I18n.locale == :ru
    self.footer_en = footer if I18n.locale == :en
    self.footer_de = footer if I18n.locale == :de
  end
  
end
