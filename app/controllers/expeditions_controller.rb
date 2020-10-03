class ExpeditionsController < ApplicationController

    def index
        @expeditions = Expedition.all
    end

    def new
        @expedition = Expedition.new
        3.times do
            @expedition.equipment.build
        end
        @equipment = Equipment.all
    end

    def create
        @expedition = Expedition.new(expedition_params)
        if @expedition.save
            redirect_to expeditions_path
        else
            render :new
        end
        #binding.pry
    end

    private
    # the params requrire that you be part of an expedition. We require that their is a name, discription, length, difficulty
    def expedition_params ## => our params say that equipment_ids is a valid vield which is why we have a setter method for it!
        params.require(:expedition).permit(:name, :description, :length, :difficulty, equipment_ids: [], equipment_attributes: [:name]) # the equipment field return a name
    end

end

############### - when you add     accepts_nested_attributes_for :equipment in the Expedition class we get the following in the params:
# "equipment_attributes"=>{"0"=>{"name"=>" Coat"}, "1"=>{"name"=>"Hat"}, "2"=>{"name"=>""}}
# see below:
# Parameters: {"authenticity_token"=>"Kfwd7T83uK7T6ffTDY9pRtdOqXilyiI9VxyAvcJ4v17f86+/SoFQeILQhjrBGm0ER0sZqj0ZjocnHEI7WsWXCw==", "expeditio
# n"=>{"name"=>"Expedition Test", "description"=>"Description", "length"=>"1.25", "difficulty"=>"Easy", "equipment_ids"=>["", "2", "8"],
# "equipment_attributes"=>{"0"=>{"name"=>" Coat"}, "1"=>{"name"=>"Hat"}, "2"=>{"name"=>""}}}, "commit"=>"Create Expedition"}
###############




##############
#### :expedition_equipment_ids, #=> [1,3,5]
#### :expedition_equipments=, [ExpeditionEquipment instances]
#### :expedition_equipment_ids=, [1,2,3,5]
#### :equipment_ids, #=> [1,2,3,5]
#### :equipment_ids=, [1,2,3,5]
##############
#-----------> we can say we just want to add in just 1 and that will do the following:
#2.6.1 :007 > e.equipment_ids=[1]
#  Equipment Load (0.2ms)  SELECT "equipment".* FROM "equipment" WHERE "equipment"."id" = ?  [["id", 1]]
# Equipment Load (0.2ms)  SELECT "equipment".* FROM "equipment" INNER JOIN "expedition_equipments" ON "equipment"."id" = "expedition_equipments"."equipment_id" WHERE "expediti
#on_equipments"."expedition_id" = ?  [["expedition_id", 14]]
#   (1.0ms)  begin transaction
#  ExpeditionEquipment Destroy (0.5ms)  DELETE FROM "expedition_equipments" WHERE "expedition_equipments"."expedition_id" = ? AND "expedition_equipments"."equipment_id" IN (?,
#?, ?, ?)  [["expedition_id", 14], ["equipment_id", 2], ["equipment_id", 6], ["equipment_id", 7], ["equipment_id", 8]]
#   (0.7ms)  commit transaction
#  => [1]

## renders this:
# Bering's Straits
# Length: Google the other with binoculars
#
# Length: 200.0 KM
#
# Difficulty: Hard
#
# Required Equipment
#
# Boots

#------> it actually deletes all of the equipment that I did not need


# BUT IF I GIVE IT MULTIPLE!!

#2.6.1 :008 > e.equipment_ids=[1,3,6,9]
#  Equipment Load (0.3ms)  SELECT "equipment".* FROM "equipment" WHERE "equipment"."id" IN (?, ?, ?, ?)  [["id", 1], ["id", 3], ["id", 6], ["id", 9]]
#   (0.1ms)  begin transaction
#  ExpeditionEquipment Create (0.6ms)  INSERT INTO "expedition_equipments" ("expedition_id", "equipment_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["expedition_id",
# 14], ["equipment_id", 3], ["created_at", "2020-10-02 07:48:28.084270"], ["updated_at", "2020-10-02 07:48:28.084270"]]
#  ExpeditionEquipment Create (0.1ms)  INSERT INTO "expedition_equipments" ("expedition_id", "equipment_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["expedition_id",
# 14], ["equipment_id", 6], ["created_at", "2020-10-02 07:48:28.094756"], ["updated_at", "2020-10-02 07:48:28.094756"]]
#  ExpeditionEquipment Create (0.1ms)  INSERT INTO "expedition_equipments" ("expedition_id", "equipment_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["expedition_id",
# 14], ["equipment_id", 9], ["created_at", "2020-10-02 07:48:28.096031"], ["updated_at", "2020-10-02 07:48:28.096031"]]
#   (0.6ms)  commit transaction
# => [1, 3, 6, 9]

## renders this:

# Bering's Straits
# Length: Google the other with binoculars
#
# Length: 200.0 KM
#
# Difficulty: Hard
#
# Required Equipment
#
# Boots
# Bug Spray
# Show Boots
# Stuff


#---------> it is going to insert in those addtional records.
# thus- assiciated those equipment because they are already in the database we are not creating the equipment we are just creating the join table
## records to associated them to

##############

#equipment_ids
## - you can use the built in method of equipment_ids which is on Expedition's instances or you can expand it in the Expedition Class
#### - the following would allow you to overwrite the defaults that you get with active record(the one that you inherit from ApplicationRecord):
# def equipment_ids=(equipment_ids)
#
# end











##############

# {
# "authenticity_token"=>"jelm/D0PRBvocO+o6jVuqj3+i6Yhv/75iIJp5YWUkNxk/wd8daZIS
# ewtx3I3M04NZcV0t88laTNYUSN8HzUHEg==",
# "expedition"=>{
#     "name"=>"Test1",
#     "description"=>"Test1 Description",
#     "length"=>"1.25",
#     "difficulty"=>"Medium",
#     "equipment_ids"=>["1", "2", "4", "6"],
#     "equipment"=>[
#         {"name"=>"stuff stuff"},
#         {"name"=>""},
#         {"name"=>""},
#         {"name"=>""},
#         {"name"=>""}
#         ]
#     }
# }
######
######
# Unpermitted parameter: :equipment_ids
# {
#     "name"=>"Test1",
#     "description"=>"Test1 Description",
#     "length"=>"1.25",
#     "difficulty"=>"Medium",
#     "equipment"=>[
#         {"name"=>"stuff stuff"},
#         {"name"=>""},
#         {"name"=>""},
#         {"name"=>""}
#     ]
# }
######






# {
# "authenticity_token"=>"t3qsc9hc9RW+6G/aZV7meIwkS5PR1bEoTJGEphdBWpeLArp6pxGvrBPJf05j534XvFhp7+R3iRK189cGUb88fg==",
# "expedition"=>
# {"name"=>"Test",
#     "description"=>"Test Description",
#     "length"=>"1.25",
#     "difficulty"=>"Easy"
# },
# "controller"=>"expeditions",
# "action"=>"create"
# }


# we are only going to let this type of information pass into our active record method to protect our database

#ActiveModel::ForbiddenAttributesError: ActiveModel::ForbiddenAttributesError ??
#
# {
# "expedition"=>{
#     "name"=>"Everglades",
#     "description"=>"Tread through disgusting swamp and avoid mosquitos, alligators and death",
#     "length"=>"0.50",
#     "difficulty"=>"Moderate",
#     "equipment"=>[
#         {"name"=>"Bug Spray"},
#         {"name"=>"Pants"},
#         {"name"=>"Long Sleeve Shirt"},
#         {"name"=>"Water Boots"},
#         {"name"=>"Alligator Detector"}
#         ]
#     }
# }
