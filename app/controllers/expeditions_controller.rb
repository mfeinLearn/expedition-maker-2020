class ExpeditionsController < ApplicationController

    def index
        @expeditions = Expedition.all
    end

    def new
        @expedition = Expedition.new
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
    def expedition_params
        params.require(:expedition).permit(:name, :description, :length, :difficulty, equipment_ids: [], equipment: [:name]) # the equipment field return a name
    end

end

######
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
