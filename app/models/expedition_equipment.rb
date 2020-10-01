class ExpeditionEquipment < ApplicationRecord
  belongs_to :expedition
  belongs_to :equipment
end
# rails g model ExpeditionEquipment expedition:references equipment:references --no-test-framework
## ^^ creates the belongs to relationship
