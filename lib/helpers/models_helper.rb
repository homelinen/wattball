class ModelsHelper
    
    # Get all models
    def self.all_models
        ActiveRecord::Base.descendants.collect { |type| type.name }
    end
end
