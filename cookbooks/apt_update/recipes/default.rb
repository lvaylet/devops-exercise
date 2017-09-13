apt_update 'Update the apt cache daily' do
  frequency 86_400  # in seconds, so once every 24 hours
  action :periodic
end
