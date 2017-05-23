class OrganizationsListing < Listings::Base
  model do
    raise unless current_user.is_admin
    Organization.order('accepted DESC')
  end

  scope 'Todas', :all, default: true
  scope 'Pendientes', :pending

  column :name, searchable: true
  column :email
  column :telephone_number
  column :legally_formed do |organization, value|
    raw('<i class="material-icons">check</i>') if value
  end
  column :twitter
  column :facebook
  column user: :name do |organization, value|
    "#{organization.user.name} (#{organization.user.email})" if organization.user
  end
  column :accepted do |organization, value|
    raw('<i class="material-icons">check</i>') if value
  end

  column '' do |organization|
    link_to 'Editar', edit_organization_path(organization)
  end
  column '' do |organization|
    link_to 'Borrar', organization, :method => :delete, :data => { :confirm => '¿Borrar esta organización?' }
  end
end
