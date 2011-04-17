class ContactsController < ApplicationController
  
  before_filter :authenticate_admin!, :only => [:edit, :update]

  def show
    @contacts = get_contacts
  end

  def edit
    @contacts = get_contacts
  end

  def update
    @contacts = Contact.find_by_locale(I18n.locale.to_s)

    if @contacts.update_attributes(params[:contact])
      redirect_to contacts_path, :notice => t("contacts.notices.updated")
    else
      render :edit
    end
  end

  protected

  def get_contacts
    contacts = Contact.find_by_locale(I18n.locale.to_s)

    if contacts.nil?
      contacts = Contact.create(:lat => 0, :long => 0, :locale => I18n.locale.to_s)
    end

    return contacts
  end
end
