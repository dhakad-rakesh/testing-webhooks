namespace :casino do
  desc "Create casino menus and assign casino items"
  task create_menus_and_assign_items: :environment do
    Casino::CreateMenusAndAssignItems.execute
  end
end
