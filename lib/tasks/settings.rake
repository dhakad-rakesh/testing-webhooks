namespace :settings do
  desc "Create default settings"
  task create: :environment do
    setting = GammabetSetting.find_or_initialize_by(setting_of: :application)
    setting.update(Constants::DEFAULT_SETTINGS)
  end
end
