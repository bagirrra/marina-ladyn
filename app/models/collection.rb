class Collection < ActiveRecord::Base  
  before_validation :extract_extension
  validates_presence_of :uploaded_icon, :if => :new_record?
  validates_inclusion_of :icon_ext, :in => %w(.jpg .png .gif)  
     
  before_save :set_defaults
      
  attr_accessor :uploaded_icon
  attr_accessor :name
  
  has_many :images, :dependent => :destroy

  after_find :set_properties
  
  protected
  
  def extract_extension    
    self.icon_ext = File.extname(uploaded_icon.original_filename) unless uploaded_icon.nil?
  end
  
  def set_defaults
    self.group ||= 'Collections'
  end

  def set_properties
    self.name = case I18n.locale
      when :ru then name_ru
      when :en then name_en
      when :de then name_de
    end 
  end
  
end
