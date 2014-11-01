ActiveAdmin.register Agent do

  actions :all, except: :destroy

  permit_params :agent_name, :email

  index do
    column :agent_name, sortable: :agent_name do |agent|
      link_to agent.agent_name, admin_agent_path(agent)
    end
    column :email, sortable: :email
  end

  show do |agent|
    attributes_table do
      row :agent_name
      row :email
    end

    panel "#{pluralize(agent.sponsors.count, 'Sponsor')}" do
      table_for agent.sponsors do
        column :name
        column :gender
        column :country
        column :status
        column :request_fulfilled
        column 'Orphans sponsored' do |_sponsor|
          _sponsor.orphans.count
        end
      end
    end
  end

end
