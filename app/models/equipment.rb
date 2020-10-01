class Equipment < ApplicationRecord
    has_many :expedition_equipments
    has_many :expeditions, through: :expedition_equipments

    validates :name, presence: :true
end
