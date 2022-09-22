class ApplicationRecord < ActiveRecord::Base
  resourcify
  self.abstract_class = true
  self.per_page = Constants::PERPAGE
end
