require "frozen_yogurt/version"

module FrozenYogurt
  class Error < StandardError; end
    class Building
    attr_accessor :id, :name, :address, :height, :construction_date, :architect
    def initialize(input_options)
      @id = input_options["id"]
      @name = input_options["name"]
      @address  = input_options["address"]
      @height = input_options["height"]
      @construction_date = input_options["construction_date"]
      @architect = input_options["architect"]
    end

    def self.find(input_id)
      response = HTTP.get("http://localhost:3000/api/buildings/#{input_id}")
      building_hash = response.parse
      Building.new(building_hash)
    end

    def self.all
      response = HTTP.get("http://localhost:3000/api/buildings")
      building_array = response.parse

      all_building_objects = []
      building_array.each do |building| 
        all_building_objects << Building.new(building)
      end
      all_building_objects
    end

    def self.create(params_hash)
      response = HTTP.post(
                           "http://localhost:3000/api/buildings", 
                           form: params_hash
                          )
      new_building = response.parse
      Building.new(new_building)
    end 

    def update(input_hash)
      response = HTTP.patch(
                            "http://localhost:3000/api/buildings/#{id}", 
                            form: input_hash
                            )
    end

    def destroy
      response = HTTP.delete("http://localhost:3000/api/buildings/#{id}")
    end

  end

end
