class Expedition < ApplicationRecord
    has_many :expedition_equipments
    has_many :equipment, through: :expedition_equipments

    accepts_nested_attributes_for :equipment

    # def equipment_ids=(equipment_ids) ## doing some overwriting of the built in equipment_ids method
    #     #equipment_items = []
    #     equipment_ids.each do |equipment_id|
    #         self.equipment << Equipment.find_by(id: equipment_id)
    #     end
    # end

    def equipment_attributes=(equipment_attributes)
        # [{"name"=>"Bug Spray "}, {"name"=>"Water Boots"}, {"name"=>""}, {"name"=>""}, {"name"=>""}]
        equipment_attributes.each do |key, value|
            if !value[:name].empty?
                if new_item = Equipment.find_by(name: value[:name])
                    self.equipment << new_item
                else
                    self.equipment.build(name: value[:name])
                end
            end
        end
    end
end

###############################################
# equipment_attributes
#
# => {"0"=>{"name"=>" Coat"}, "1"=>{"name"=>"Hat"}, "2"=>{"name"=>""}}
###############################################



# expedition -< expedition_equipments >-equipments

# Equipment.new(
#     name: params[:name],
#     description: params[:description],
#     length: params[:length],
#     difficulty: params[:difficulty],
#     equipment: params[:equipment]
# )
