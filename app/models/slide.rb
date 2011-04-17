class Slide < ActiveRecord::Base
  before_validation :extract_extension
  validates_presence_of :uploaded_file
  validates_inclusion_of :file_ext, :in => %w(.jpg .png .gif)
          
  attr_accessor :uploaded_file
  
  protected

  def extract_extension    
    self.file_ext = File.extname(uploaded_file.original_filename) unless uploaded_file.nil?
  end  
end
