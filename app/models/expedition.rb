class Expedition < ApplicationRecord
    has_many :expedition_equipments
    has_many :equipment, through: :expedition_equipments

    # def equipment_ids=(equipment_ids)
    #     #equipment_items = []
    #     equipment_ids.each do |equipment_id|
    #         self.equipment << Equipment.find_by(id: equipment_id)
    #     end
    # end

    def equipment=(equipment)
        # [{"name"=>"Bug Spray "}, {"name"=>"Water Boots"}, {"name"=>""}, {"name"=>""}, {"name"=>""}]
        equipment.each do |item|
            if !item[:name].empty?
                if new_item = Equipment.find_by(name: item[:name])
                    self.equipment << new_item
                else
                    self.equipment.build(name: item[:name])
                end
            end
        end
    end
end


# expedition -< expedition_equipments >-equipments

# Equipment.new(
#     name: params[:name],
#     description: params[:description],
#     length: params[:length],
#     difficulty: params[:difficulty],
#     equipment: params[:equipment]
# )
